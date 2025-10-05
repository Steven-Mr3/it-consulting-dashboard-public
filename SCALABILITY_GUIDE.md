# 🚀 Guía de Escalabilidad - IT Consulting Dashboard

## 📊 Estado Actual vs. Estado Escalable

### Estado Actual (MVP)
- SQLite3 (desarrollo/demo)
- Sin caché
- Sin jobs en background
- Sin CDN
- Servidor único
- ~100 usuarios simultáneos

### Estado Escalable (Producción Enterprise)
- PostgreSQL con réplicas
- Redis para caché y jobs
- Workers en background
- CDN para assets
- Load balancers
- ~100,000+ usuarios simultáneos

---

## 🏗️ Arquitectura Escalable

```
┌─────────────────────────────────────────────────────┐
│                   USUARIOS                          │
└──────────────────┬──────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────┐
│              CDN (Cloudflare/CloudFront)            │
│              - Assets estáticos                     │
│              - Cache global                         │
└──────────────────┬──────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────┐
│         Load Balancer (nginx/AWS ELB)               │
│         - Distribución de tráfico                   │
│         - SSL/TLS termination                       │
└──────────────────┬──────────────────────────────────┘
                   │
        ┌──────────┴──────────┐
        ▼                     ▼
┌───────────────┐    ┌───────────────┐
│  Rails App 1  │    │  Rails App 2  │ ... N instancias
│  (Web Server) │    │  (Web Server) │
└───────┬───────┘    └───────┬───────┘
        │                    │
        └──────────┬─────────┘
                   │
    ┌──────────────┼──────────────┐
    ▼              ▼              ▼
┌────────┐    ┌────────┐    ┌──────────┐
│ Redis  │    │  DB    │    │ Sidekiq  │
│ Cache  │    │ Master │    │ Workers  │
└────────┘    └───┬────┘    └──────────┘
                  │
           ┌──────┴──────┐
           ▼             ▼
      ┌────────┐    ┌────────┐
      │ DB     │    │ DB     │
      │ Replica│    │ Replica│
      └────────┘    └────────┘
```

---

## 1️⃣ Base de Datos Escalable

### Migrar a PostgreSQL

**Gemfile:**
```ruby
# Reemplazar sqlite3 con:
gem 'pg', '~> 1.5'
```

**config/database.yml:**
```yaml
production:
  primary: &primary_production
    adapter: postgresql
    encoding: unicode
    pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 20 } %>
    host: <%= ENV['DATABASE_HOST'] %>
    database: <%= ENV['DATABASE_NAME'] %>
    username: <%= ENV['DATABASE_USERNAME'] %>
    password: <%= ENV['DATABASE_PASSWORD'] %>

  # Réplica de lectura
  replica:
    <<: *primary_production
    host: <%= ENV['DATABASE_REPLICA_HOST'] %>
    replica: true
```

### Índices de Base de Datos

Crear migración para índices de performance:

```ruby
class AddPerformanceIndexes < ActiveRecord::Migration[8.0]
  def change
    # Tickets
    add_index :tickets, [:client_id, :status]
    add_index :tickets, [:assigned_to_id, :status]
    add_index :tickets, [:created_at]
    add_index :tickets, [:priority, :status]

    # Búsquedas full-text
    add_index :tickets, :title, using: :gin, opclass: :gin_trgm_ops
    add_index :tickets, :description, using: :gin, opclass: :gin_trgm_ops
    add_index :kb_articles, :title, using: :gin, opclass: :gin_trgm_ops
    add_index :kb_articles, :content, using: :gin, opclass: :gin_trgm_ops

    # Clientes
    add_index :clients, :name
    add_index :clients, :contract_end

    # Usuarios
    add_index :users, [:role, :client_id]

    # Comentarios
    add_index :comments, [:ticket_id, :created_at]
  end
end
```

### Particionamiento de Tablas

Para tickets históricos (millones de registros):

```ruby
# Particionar tickets por mes
class PartitionTicketsByMonth < ActiveRecord::Migration[8.0]
  def up
    execute <<-SQL
      CREATE TABLE tickets_partitioned (
        LIKE tickets INCLUDING ALL
      ) PARTITION BY RANGE (created_at);

      -- Crear particiones por mes
      CREATE TABLE tickets_2025_01 PARTITION OF tickets_partitioned
        FOR VALUES FROM ('2025-01-01') TO ('2025-02-01');

      CREATE TABLE tickets_2025_02 PARTITION OF tickets_partitioned
        FOR VALUES FROM ('2025-02-01') TO ('2025-03-01');
    SQL
  end
end
```

---

## 2️⃣ Sistema de Caché con Redis

### Instalar Redis

**Gemfile:**
```ruby
gem 'redis', '~> 5.0'
gem 'redis-namespace'
gem 'hiredis', '~> 0.6.3'
```

**config/environments/production.rb:**
```ruby
config.cache_store = :redis_cache_store, {
  url: ENV['REDIS_URL'],
  namespace: 'it_dashboard',
  expires_in: 1.hour,
  pool_size: ENV.fetch('RAILS_MAX_THREADS', 5).to_i,
  pool_timeout: 5
}

# Session store
config.session_store :redis_store, {
  servers: ENV['REDIS_URL'],
  expire_after: 24.hours,
  key: '_it_dashboard_session'
}
```

### Cachear Métricas del Dashboard

**app/controllers/dashboard_controller.rb:**
```ruby
class DashboardController < ApplicationController
  def index
    @sla_compliance = Rails.cache.fetch('dashboard:sla_compliance', expires_in: 5.minutes) do
      calculate_sla_compliance
    end

    @mttr = Rails.cache.fetch('dashboard:mttr', expires_in: 5.minutes) do
      calculate_mttr
    end

    @chart_data = Rails.cache.fetch('dashboard:chart_data', expires_in: 15.minutes) do
      generate_chart_data
    end
  end

  private

  def calculate_sla_compliance
    # Cálculo costoso cacheado
    Ticket.resolved
          .where('resolved_at <= created_at + (clients.sla_response_time * interval \'1 minute\')')
          .joins(:client)
          .count
          .to_f / Ticket.resolved.count * 100
  rescue
    0
  end
end
```

### Fragment Caching en Vistas

**app/views/tickets/index.html.erb:**
```erb
<% @tickets.each do |ticket| %>
  <%= cache(ticket) do %>
    <div class="ticket-card">
      <%= render partial: 'ticket_card', locals: { ticket: ticket } %>
    </div>
  <% end %>
<% end %>
```

---

## 3️⃣ Jobs en Background con Sidekiq

### Instalar Sidekiq

**Gemfile:**
```ruby
gem 'sidekiq', '~> 7.2'
gem 'sidekiq-scheduler'
```

**config/sidekiq.yml:**
```yaml
:concurrency: 25
:max_retries: 3
:queues:
  - critical
  - default
  - low

:schedule:
  sla_monitor:
    cron: '*/5 * * * *'  # Cada 5 minutos
    class: SlaMonitorJob

  daily_report:
    cron: '0 9 * * *'  # 9 AM diario
    class: DailyReportJob
```

### Jobs Críticos

**app/jobs/sla_monitor_job.rb:**
```ruby
class SlaMonitorJob < ApplicationJob
  queue_as :critical

  def perform
    # Buscar tickets que están por vencer el SLA
    overdue_tickets = Ticket.open
      .joins(:client)
      .where("created_at + (clients.sla_response_time * interval '1 minute') < ?",
             Time.current + 30.minutes)

    overdue_tickets.find_each do |ticket|
      # Crear alerta
      Alert.create!(
        alert_type: 'SLA Warning',
        message: "Ticket ##{ticket.id} - #{ticket.title} está cerca de vencer el SLA",
        severity: :warning,
        ticket: ticket
      )

      # Enviar notificación
      SlackNotificationJob.perform_later(ticket.id)
      EmailNotificationJob.perform_later(ticket.id)
    end
  end
end
```

**app/jobs/email_notification_job.rb:**
```ruby
class EmailNotificationJob < ApplicationJob
  queue_as :default

  def perform(ticket_id)
    ticket = Ticket.find(ticket_id)
    TicketMailer.sla_warning(ticket).deliver_now
  end
end
```

**app/jobs/report_generation_job.rb:**
```ruby
class ReportGenerationJob < ApplicationJob
  queue_as :low

  def perform(user_id, params)
    user = User.find(user_id)
    report = ReportService.generate(params)

    # Guardar en S3 o almacenamiento
    report_url = store_report(report)

    # Enviar email con link
    ReportMailer.ready(user, report_url).deliver_now
  end
end
```

---

## 4️⃣ Búsqueda Avanzada con Elasticsearch

**Gemfile:**
```ruby
gem 'searchkick'
gem 'elasticsearch', '~> 8.0'
```

**app/models/ticket.rb:**
```ruby
class Ticket < ApplicationRecord
  searchkick word_start: [:title],
             highlight: [:title, :description],
             callbacks: :async

  def search_data
    {
      title: title,
      description: description,
      client_name: client.name,
      status: status,
      priority: priority,
      created_at: created_at,
      tags: [client.name, status, priority, category]
    }
  end
end
```

**Búsqueda:**
```ruby
# app/controllers/tickets_controller.rb
def index
  @tickets = Ticket.search(
    params[:query],
    where: { status: params[:status] },
    page: params[:page],
    per_page: 25,
    highlight: true
  )
end
```

---

## 5️⃣ API REST Escalable

### Versionado de API

**config/routes.rb:**
```ruby
namespace :api do
  namespace :v1 do
    resources :tickets
    resources :clients
    resources :kb_articles
    resources :alerts
  end
end
```

**app/controllers/api/v1/base_controller.rb:**
```ruby
module Api
  module V1
    class BaseController < ActionController::API
      include Pagy::Backend

      before_action :authenticate_api_token!

      rescue_from ActiveRecord::RecordNotFound, with: :not_found
      rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity

      private

      def authenticate_api_token!
        token = request.headers['Authorization']&.split(' ')&.last
        @current_user = User.find_by(api_token: token)

        render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_user
      end

      def not_found
        render json: { error: 'Not found' }, status: :not_found
      end

      def unprocessable_entity(exception)
        render json: { errors: exception.record.errors }, status: :unprocessable_entity
      end
    end
  end
end
```

### Rate Limiting

**Gemfile:**
```ruby
gem 'rack-attack'
```

**config/initializers/rack_attack.rb:**
```ruby
class Rack::Attack
  # Throttle
  throttle('api/ip', limit: 300, period: 5.minutes) do |req|
    req.ip if req.path.start_with?('/api/')
  end

  throttle('api/user', limit: 1000, period: 1.hour) do |req|
    req.env['warden'].user&.id if req.path.start_with?('/api/')
  end

  # Blacklist
  blocklist('block bad actors') do |req|
    BlockedIp.where(ip_address: req.ip).exists?
  end
end
```

---

## 6️⃣ Monitoring y Observabilidad

### Application Performance Monitoring (APM)

**Gemfile:**
```ruby
gem 'skylight'
# O
gem 'newrelic_rpm'
# O
gem 'scout_apm'
```

### Logging Estructurado

**config/environments/production.rb:**
```ruby
config.logger = ActiveSupport::Logger.new(STDOUT)
config.log_level = :info
config.log_tags = [:request_id, :remote_ip]

# Lograge para logs estructurados
config.lograge.enabled = true
config.lograge.formatter = Lograge::Formatters::Json.new
```

### Health Checks

**app/controllers/health_controller.rb:**
```ruby
class HealthController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    checks = {
      database: check_database,
      redis: check_redis,
      sidekiq: check_sidekiq,
      elasticsearch: check_elasticsearch
    }

    status = checks.values.all? ? :ok : :service_unavailable
    render json: { status: status, checks: checks }, status: status
  end

  private

  def check_database
    ActiveRecord::Base.connection.active?
  rescue
    false
  end

  def check_redis
    Redis.current.ping == 'PONG'
  rescue
    false
  end
end
```

---

## 7️⃣ CDN y Assets Optimization

### Usar S3 + CloudFront para Assets

**Gemfile:**
```ruby
gem 'aws-sdk-s3'
```

**config/storage.yml:**
```yaml
amazon:
  service: S3
  access_key_id: <%= ENV['AWS_ACCESS_KEY_ID'] %>
  secret_access_key: <%= ENV['AWS_SECRET_ACCESS_KEY'] %>
  region: us-east-1
  bucket: it-dashboard-assets
```

### Image Optimization

**Gemfile:**
```ruby
gem 'image_processing', '~> 1.12'
gem 'mini_magick'
```

---

## 8️⃣ Database Connection Pooling

**config/database.yml:**
```yaml
production:
  adapter: postgresql
  pool: <%= ENV.fetch("DATABASE_POOL_SIZE") { 20 } %>
  timeout: 5000
  checkout_timeout: 5
  reaping_frequency: 10

  # Para PgBouncer
  prepared_statements: false
  advisory_locks: false
```

---

## 9️⃣ Horizontal Scaling

### Docker + Kubernetes

**Dockerfile:**
```dockerfile
FROM ruby:3.2.2-alpine

RUN apk add --no-cache \
    postgresql-dev \
    nodejs \
    npm \
    git \
    build-base

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4

COPY . .

RUN rails tailwindcss:build
RUN rails assets:precompile

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
```

**docker-compose.yml:**
```yaml
version: '3.8'

services:
  app:
    build: .
    ports:
      - "3000:3000"
    depends_on:
      - db
      - redis
    environment:
      DATABASE_URL: postgresql://postgres:password@db/dashboard_production
      REDIS_URL: redis://redis:6379/0
    deploy:
      replicas: 4  # 4 instancias de la app

  db:
    image: postgres:16
    environment:
      POSTGRES_PASSWORD: password
    volumes:
      - postgres_data:/var/lib/postgresql/data

  redis:
    image: redis:7-alpine
    volumes:
      - redis_data:/data

  sidekiq:
    build: .
    command: bundle exec sidekiq
    depends_on:
      - db
      - redis
    deploy:
      replicas: 2  # 2 workers

  nginx:
    image: nginx:alpine
    ports:
      - "80:80"
    depends_on:
      - app
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf

volumes:
  postgres_data:
  redis_data:
```

---

## 🔟 Optimizaciones de Rails

### Eager Loading

```ruby
# Mal - N+1 queries
@tickets = Ticket.all
@tickets.each { |t| puts t.client.name }

# Bien - 1 query
@tickets = Ticket.includes(:client, :assigned_to, :created_by)
@tickets.each { |t| puts t.client.name }
```

### Counter Caches

```ruby
class Client < ApplicationRecord
  has_many :tickets
end

class AddCounterCaches < ActiveRecord::Migration[8.0]
  def change
    add_column :clients, :tickets_count, :integer, default: 0

    Client.find_each do |client|
      Client.reset_counters(client.id, :tickets)
    end
  end
end

# Ahora en vez de:
client.tickets.count  # Query a DB

# Usas:
client.tickets_count  # Valor en memoria
```

---

## 📊 Métricas de Escalabilidad

### Pequeño (MVP)
- **Usuarios:** 10-100
- **Tickets/día:** 10-50
- **DB:** SQLite3
- **Servidor:** 1 instancia
- **Costo:** ~$10-20/mes

### Mediano (Startup)
- **Usuarios:** 100-1,000
- **Tickets/día:** 50-500
- **DB:** PostgreSQL (single instance)
- **Servidor:** 2-3 instancias
- **Redis:** 1 instancia
- **Costo:** ~$100-200/mes

### Grande (Empresa)
- **Usuarios:** 1,000-10,000
- **Tickets/día:** 500-5,000
- **DB:** PostgreSQL (master + 2 réplicas)
- **Servidores:** 5-10 instancias
- **Redis:** Cluster
- **Sidekiq:** 3-5 workers
- **Costo:** ~$500-1,000/mes

### Enterprise (Corporativo)
- **Usuarios:** 10,000-100,000+
- **Tickets/día:** 5,000-50,000+
- **DB:** PostgreSQL (cluster multi-región)
- **Servidores:** Auto-scaling 10-50 instancias
- **Redis:** Cluster multi-AZ
- **Sidekiq:** Auto-scaling workers
- **CDN:** Global
- **Elasticsearch:** Cluster
- **Costo:** ~$5,000-15,000/mes

---

## 🚀 Plan de Implementación por Fases

### Fase 1: Foundation (Semana 1-2)
- [ ] Migrar a PostgreSQL
- [ ] Agregar índices básicos
- [ ] Implementar Redis para sesiones

### Fase 2: Performance (Semana 3-4)
- [ ] Implementar caché de queries
- [ ] Fragment caching en vistas
- [ ] Optimizar N+1 queries

### Fase 3: Background Jobs (Semana 5-6)
- [ ] Implementar Sidekiq
- [ ] Mover emails a background
- [ ] Implementar SLA monitoring job

### Fase 4: Search & API (Semana 7-8)
- [ ] Implementar Elasticsearch
- [ ] Crear API REST versionada
- [ ] Implementar rate limiting

### Fase 5: Monitoring (Semana 9-10)
- [ ] Implementar APM (Skylight/New Relic)
- [ ] Configurar logs estructurados
- [ ] Health checks y alertas

### Fase 6: Scaling (Semana 11-12)
- [ ] Dockerizar aplicación
- [ ] Configurar Kubernetes/ECS
- [ ] Implementar auto-scaling
- [ ] CDN para assets

---

## 📚 Recursos Adicionales

- [Rails Performance Best Practices](https://guides.rubyonrails.org/performance_testing.html)
- [Sidekiq Best Practices](https://github.com/sidekiq/sidekiq/wiki/Best-Practices)
- [PostgreSQL Performance Tuning](https://wiki.postgresql.org/wiki/Performance_Optimization)
- [Redis Best Practices](https://redis.io/docs/manual/patterns/)

---

**Última actualización:** Octubre 2025
**Versión del Dashboard:** 1.0.0
