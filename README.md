# 🚀 IT Consulting Dashboard - Enterprise Support Platform

[![Ruby](https://img.shields.io/badge/Ruby-3.2.2-red.svg)](https://www.ruby-lang.org/)
[![Rails](https://img.shields.io/badge/Rails-8.0.2-red.svg)](https://rubyonrails.org/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

> **Plataforma profesional de gestión de servicios IT con soporte ITIL, monitoreo de SLA, y análisis avanzado de métricas**

Una solución completa y escalable para empresas de consultoría IT, MSPs y departamentos de soporte técnico que necesitan gestionar tickets, clientes, SLAs y base de conocimiento de forma eficiente.

## 🌐 Demo en Vivo

**[🚀 Ver Demo](https://it-consulting-dashboard.onrender.com)**

**Credenciales de acceso:**
- **Admin:** `admin@example.com` / `password123`
- **Consultor:** `consultant1@example.com` / `password123`
- **Cliente:** `john@techcorp.com` / `password123`

> ⚠️ **Nota:** La demo gratuita se duerme tras 15 minutos de inactividad. La primera carga puede tardar ~30 segundos.

[💼 **LinkedIn**](https://www.linkedin.com/in/steven-mart%C3%ADnez?lipi=urn%3Ali%3Apage%3Ad_flagship3_profile_view_base_contact_details%3BGLLkoTdeQ0arzc1wjdD2oQ%3D%3D) | [🐛 **Reportar Bug**](../../issues)

---

## 📸 Capturas de Pantalla

> 📷 *Screenshots disponibles próximamente*

### Dashboard Principal con KPIs en Tiempo Real
- KPIs en tiempo real (SLA Compliance, MTTR, Uptime)
- Gráficas interactivas de tendencias (últimos 30 días)
- Vista general de tickets y alertas

### Gestión Avanzada de Tickets
- Sistema de tickets multi-estado con SLA tracking
- Asignación automática y priorización inteligente
- Comentarios en tiempo real

### Base de Conocimiento Inteligente
- Búsqueda avanzada full-text
- Sistema de rating y tracking de vistas
- Auto-sugerencia de artículos relacionados

---

## ⭐ Características Principales

### 🎯 Gestión de Servicios ITIL

- ✅ **Tickets Multi-estado**: Flujo completo Open → In Progress → Resolved → Closed
- ✅ **Priorización Inteligente**: 4 niveles (Low, Medium, High, Critical)
- ✅ **Categorización**: Incident, Request, Change, Problem
- ✅ **Asignación Automática**: Distribución a consultores disponibles
- ✅ **Comentarios en Tiempo Real**: Comunicación fluida con clientes

### 📊 KPIs y Analytics Empresariales

- 📈 **SLA Compliance Rate**: Monitoreo automático de cumplimiento
- ⏱️ **MTTR (Mean Time To Repair)**: Tiempo promedio de resolución
- ⚡ **System Uptime**: Disponibilidad del servicio
- 📉 **Trend Analysis**: Gráficas de los últimos 30 días
- 🎯 **Custom Dashboards**: Métricas personalizables por cliente

### 🏢 Multi-Tenancy (Multi-Cliente)

- 👥 **Gestión de Clientes**: CRM integrado para empresas
- 📝 **SLA Personalizado**: Configuración por cliente
- 📅 **Contratos**: Tracking de fechas inicio/fin
- 📊 **Reportes por Cliente**: Analytics individualizados
- 🔐 **Acceso Segregado**: Clientes solo ven sus datos

### 📚 Base de Conocimiento (KB)

- 🔍 **Búsqueda Avanzada**: Full-text search en artículos
- 📂 **Categorización**: Organización por temas
- ⭐ **Rating System**: Útil/No útil con estadísticas
- 👁️ **Tracking de Vistas**: Artículos más consultados
- 🚀 **Auto-sugerencia**: Artículos relacionados a tickets

### 🔔 Sistema de Alertas Inteligente

- ⚠️ **SLA Breach Warnings**: Alertas automáticas pre-vencimiento
- 🔴 **Tickets Críticos**: Notificaciones de alta prioridad
- 📧 **Email Notifications**: Integración con mailer
- 📱 **Real-time Alerts**: Dashboard de alertas activas
- ✅ **Workflow de Resolución**: Marcar como resueltas

### 🎨 Diseño Profesional Dark Theme

- 🌙 **Tema Oscuro Optimizado**: Diseñado para profesionales IT
- 📱 **100% Responsive**: Mobile, Tablet, Desktop
- ⚡ **Turbo Enabled**: Navegación SPA ultra-rápida
- 🎨 **UI/UX Moderna**: Basado en GitHub Dark Theme
- ♿ **Accesible**: WCAG 2.1 compliant

---

## 🛠️ Stack Tecnológico

| Categoría | Tecnología | Versión | Propósito |
|-----------|-----------|---------|-----------|
| **Backend** | Ruby on Rails | 8.0.2 | Framework principal |
| **Lenguaje** | Ruby | 3.2.2 | Lenguaje de programación |
| **Base de Datos** | PostgreSQL* | 16+ | Base de datos relacional |
| **Cache** | Redis* | 7+ | Cache y sessions |
| **Frontend** | Tailwind CSS | 4.3 | Framework CSS |
| **Charts** | Chart.js | 4.4 | Visualización de datos |
| **Auth** | Devise | 4.9 | Autenticación |
| **Authorization** | Pundit* | 2.5 | Control de acceso |
| **Pagination** | Pagy | 9.4 | Paginación eficiente |
| **PDF** | Wicked PDF* | 2.8 | Generación de reportes |
| **Jobs** | Sidekiq* | 7+ | Background processing |
| **Testing** | RSpec* | 3+ | Suite de testing |
| **Monitoring** | Sentry | 5.28 | Error tracking & performance |

\* *Opcional/Recomendado para producción*

---

## 🚀 Quick Start

### Prerrequisitos

```bash
# Versiones requeridas
Ruby 3.2.2+
Rails 8.0.2+
Node.js 18+ (para Tailwind CSS)
Git
```

### Instalación en 5 Minutos

#### 1. Clonar el repositorio
```bash
git clone https://github.com/tu-usuario/it-consulting-dashboard.git
cd it-consulting-dashboard
```

#### 2. Instalar dependencias
```bash
bundle install
```

#### 3. Configurar base de datos
```bash
rails db:create
rails db:migrate
rails db:seed
```

#### 4. Configurar variables de entorno (Opcional)
```bash
cp .env.example .env
# Edita .env y agrega tu SENTRY_DSN desde https://sentry.io
```

#### 5. Compilar assets (Tailwind CSS)
```bash
rails tailwindcss:build
```

#### 6. Iniciar servidor
```bash
bin/dev
# O alternativamente:
rails server
```

#### 7. Abrir en navegador
```bash
open http://localhost:3000
```

### Credenciales de Acceso (Demo)

| Rol | Email | Password |
|-----|-------|----------|
| 👑 **Admin** | admin@example.com | password123 |
| 💼 **Consultor** | consultant1@example.com | password123 |
| 👤 **Cliente** | john@techcorp.com | password123 |

---

## 📖 Documentación Detallada

#### Para Desarrolladores

- 📊 [**Guía de Escalabilidad**](SCALABILITY_GUIDE.md) - Cómo escalar a producción

#### Documentación Adicional (Próximamente)

<details>
<summary>Ver documentación planificada</summary>

**Para Usuarios:**
- 📘 Guía de Usuario - Cómo usar la plataforma
- 🎓 Tutorial de Inicio - Primeros pasos
- ❓ FAQ - Preguntas frecuentes

**Para Desarrolladores:**
- 🏗️ Guía de Arquitectura - Diseño del sistema
- 🔧 API Documentation - Endpoints REST
- 🧪 Testing Guide - Cómo escribir tests
- 🐳 Docker Guide - Deployment con contenedores

**Para Empresas:**
- 💼 Business Case - ROI y beneficios
- 🔐 Security Guide - Seguridad y compliance
- 📈 Performance Benchmarks - Métricas de rendimiento

</details>

---

## 🎯 Casos de Uso

### 1️⃣ MSP (Managed Service Provider)

> Gestiona 50+ clientes, 500+ tickets/mes, SLA del 95%

**Beneficios:**

- Monitoreo de SLA en tiempo real
- Dashboard por cliente
- Reportes automáticos mensuales
- Base de conocimiento centralizada

### 2️⃣ Departamento IT Corporativo

> 1,000+ empleados, soporte multinivel

**Beneficios:**

- Categorización por tipo de incidente
- Escalamiento automático
- Métricas de performance
- Integración con Active Directory*

### 3️⃣ Consultoría IT Freelance

> 5-10 clientes, gestión profesional

**Beneficios:**

- Imagen profesional
- SLA configurables
- Reportes para clientes
- Base de conocimiento

---

## 📊 Métricas y KPIs Incluidos

### Dashboard Analytics

```ruby
# KPIs Calculados Automáticamente
- SLA Compliance Rate (%)
- MTTR - Mean Time To Repair (horas)
- System Uptime (%)
- Open vs Closed Tickets Ratio
- Tickets por Categoría
- Tickets por Prioridad
- Tendencias (últimos 30 días)
- Top 5 Clientes
- Consultores más productivos
```

### Reportes Generables

- ✅ Reporte por Rango de Fechas
- ✅ Reporte por Cliente
- ✅ Reporte de SLA Compliance
- ✅ Reporte de Productividad
- ✅ Exportación a PDF*

---

## 📊 Monitoring & Observability

### Error Tracking con Sentry

La aplicación está integrada con **Sentry** para monitoreo de errores y performance en tiempo real.

**Configuración:**

1. Crea una cuenta gratuita en [sentry.io](https://sentry.io)
2. Crea un nuevo proyecto Rails
3. Copia tu DSN desde Project Settings → Client Keys
4. Configura la variable de entorno:
   ```bash
   SENTRY_DSN=https://your-key@your-org.ingest.sentry.io/your-project-id
   ```

**Características incluidas:**
- 🐛 **Error Tracking**: Captura automática de excepciones
- 📊 **Performance Monitoring**: Tracing de transacciones
- 🔍 **Breadcrumbs**: Contexto de acciones antes del error
- 🔐 **Data Filtering**: Parámetros sensibles filtrados automáticamente
- 📈 **Release Tracking**: Seguimiento de errores por versión

**Plan gratuito incluye:**
- 5,000 errores/mes
- 10,000 performance units/mes
- Retención de 30 días
- Alertas por email

---

## 🔐 Seguridad

### Características de Seguridad Implementadas

- ✅ **Autenticación Segura**: Devise con bcrypt
- ✅ **CSRF Protection**: Rails built-in
- ✅ **SQL Injection Prevention**: ActiveRecord ORM
- ✅ **XSS Protection**: Content Security Policy
- ✅ **Password Hashing**: bcrypt con salt
- ✅ **Session Security**: Encrypted cookies
- ✅ **Rate Limiting**: Rack::Attack (opcional)
- ✅ **Role-based Access Control**: Autorización granular
- ✅ **Error Monitoring**: Sentry con filtrado de datos sensibles

### Compliance

- ✅ GDPR Ready
- ✅ SOC 2 Compatible
- ✅ ISO 27001 Guidelines
- ✅ ITIL Framework Aligned

---

## 🚢 Deployment

### Opciones de Deployment

<details>
<summary><b>🎨 Render.com</b> (Gratis - Recomendado)</summary>

**Deploy en 3 pasos:**

```bash
# 1. Crear cuenta en render.com
# 2. New → Blueprint
# 3. Conectar este repositorio GitHub
```

**Configurar variables de entorno en Render:**
- `RAILS_MASTER_KEY`: Obtén con `cat config/master.key`
- `SENTRY_DSN`: (Opcional) Tu DSN de Sentry

**El deploy es automático:**
- Render detecta `render.yaml`
- Crea PostgreSQL automáticamente
- Ejecuta migraciones y seeds
- Tu app estará en: `https://tu-app.onrender.com`

**Plan gratuito incluye:**
- ✅ 750 horas/mes (suficiente para demo)
- ✅ PostgreSQL gratis
- ✅ SSL automático
- ⚠️ Se duerme tras 15 min inactividad
- ⏱️ Tarda ~30s en despertar

**Costo:** Gratis
</details>

<details>
<summary><b>🟦 Heroku</b> (Pago - $7/mes)</summary>

```bash
# 1. Crear app
heroku create tu-dashboard-it

# 2. Agregar PostgreSQL
heroku addons:create heroku-postgresql:mini

# 3. Agregar Redis (opcional)
heroku addons:create heroku-redis:mini

# 4. Configurar variables
heroku config:set RAILS_MASTER_KEY=$(cat config/master.key)
heroku config:set SENTRY_DSN=tu-sentry-dsn

# 5. Deploy
git push heroku main
heroku run rails db:migrate db:seed
heroku open
```

**Costo:** ~$7-25/mes (Hobby tier)
</details>

<details>
<summary><b>🚂 Railway</b> (Moderno - Muy fácil)</summary>

```bash
# 1. Conectar GitHub repo
# 2. Railway detecta automáticamente Rails
# 3. Agregar PostgreSQL plugin
# 4. Deploy automático
```

**Costo:** ~$5-20/mes (con $5 gratis/mes)
</details>

<details>
<summary><b>🐳 Docker</b> (Flexible - Cualquier host)</summary>

```bash
# 1. Build
docker build -t it-dashboard .

# 2. Run con docker-compose
docker-compose up -d

# 3. Acceder
open http://localhost:3000
```

**Costo:** Variable según hosting
</details>

<details>
<summary><b>☁️ AWS/Azure/GCP</b> (Enterprise)</summary>

Ver [SCALABILITY_GUIDE.md](./SCALABILITY_GUIDE.md) para arquitectura completa con:
- Load Balancers
- Auto-scaling
- Multi-región
- CDN

**Costo:** ~$100-1,000+/mes según escala
</details>

---

## 📈 Roadmap

### ✅ Versión 1.0 (Actual)

- [x] Gestión de Tickets CRUD
- [x] Dashboard con KPIs
- [x] Multi-cliente
- [x] Base de Conocimiento
- [x] Sistema de Alertas
- [x] Reportes básicos
- [x] Dark Theme responsive

### 🚧 Versión 1.5 (En Desarrollo)

- [ ] API REST versionada
- [ ] Webhooks para integraciones
- [ ] Email notifications
- [ ] Advanced search (Elasticsearch)
- [ ] PDF Report generation
- [ ] Slack/Teams integration

### 🔮 Versión 2.0 (Planificado)

- [ ] Real-time updates (ActionCable)
- [ ] Mobile app (React Native)
- [ ] AI-powered ticket routing
- [ ] Chatbot integration
- [ ] Time tracking
- [ ] Billing & invoicing

### 🌟 Versión 3.0 (Futuro)

- [ ] Multi-idioma (i18n)
- [ ] White-label customization
- [ ] Marketplace de integraciones
- [ ] Advanced analytics con ML
- [ ] SLA automation engine

---

## 🤝 Contribuir

¡Las contribuciones son bienvenidas! Este es un proyecto open-source.

### Cómo Contribuir

1. **Fork** el proyecto
2. **Crea** una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. **Commit** tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. **Push** a la rama (`git push origin feature/AmazingFeature`)
5. **Abre** un Pull Request

### Áreas donde Necesitamos Ayuda

- 🐛 Bug fixes
- 📝 Documentación
- 🌐 Traducciones (i18n)
- 🧪 Tests
- 🎨 Mejoras de UI/UX
- ⚡ Optimizaciones de performance

Ver [CONTRIBUTING.md](./CONTRIBUTING.md) para más detalles.

---

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver [LICENSE](./LICENSE) para más detalles.

```
MIT License - Puedes usar este software libremente para:
✅ Uso comercial
✅ Modificación
✅ Distribución
✅ Uso privado
```

---

## 👨‍💻 Autor

**Bryan Steven Martínez Ramírez**
*IT Support Lead & Full-Stack Developer*

- 💼 LinkedIn: [linkedin.com/in/bryan-martinez](https://linkedin.com/in/bryan-martinez)
- 🐙 GitHub: [@Steven-Mr3](https://github.com/Steven-Mr3)
- 📧 Email: bryansmr10@gmail.com
- 🌐 Resume: https://steven-mr3.github.io

### Experiencia Relevante

- 🎯 5+ años en soporte técnico y gestión ITIL
- 💻 Full-stack developer especializado en Rails
- 🏆 Certificaciones: ITIL Foundation, AWS Solutions Architect
- 📊 Experto en monitoreo de servidores y SLA management

---

## 💼 Para Empresas

### ¿Necesitas una Solución Personalizada?

Ofrezco servicios de:

- 🎨 **Customización**: Adaptación a tus necesidades específicas
- 🚀 **Deployment**: Instalación y configuración en tus servidores
- 📚 **Capacitación**: Training para tu equipo
- 🔧 **Soporte**: Mantenimiento y updates
- 🏗️ **Desarrollo Custom**: Features específicos para tu negocio

**Contacto:** bryansmr10@gmail.com

---

## 🙏 Agradecimientos

- [Ruby on Rails](https://rubyonrails.org/) - Framework increíble
- [Tailwind CSS](https://tailwindcss.com/) - Por el excelente sistema de diseño
- [Chart.js](https://www.chartjs.org/) - Visualizaciones hermosas
- [Devise](https://github.com/heartcombo/devise) - Autenticación robusta
- Comunidad Open Source - Por todo el conocimiento compartido

---

## 📊 Estadísticas del Proyecto

![GitHub stars](https://img.shields.io/github/stars/tu-usuario/it-consulting-dashboard?style=social)
![GitHub forks](https://img.shields.io/github/forks/tu-usuario/it-consulting-dashboard?style=social)
![GitHub watchers](https://img.shields.io/github/watchers/tu-usuario/it-consulting-dashboard?style=social)

![GitHub last commit](https://img.shields.io/github/last-commit/tu-usuario/it-consulting-dashboard)
![GitHub issues](https://img.shields.io/github/issues/tu-usuario/it-consulting-dashboard)
![GitHub pull requests](https://img.shields.io/github/issues-pr/tu-usuario/it-consulting-dashboard)

---

## 🌟 Muestra tu Apoyo

Si este proyecto te resulta útil, ¡considera darle una ⭐️!

**Comparte en redes sociales:**

[![Twitter](https://img.shields.io/twitter/url?style=social&url=https%3A%2F%2Fgithub.com%2Ftu-usuario%2Fit-consulting-dashboard)](https://twitter.com/intent/tweet?text=Check%20out%20this%20awesome%20IT%20Dashboard!)
[![LinkedIn](https://img.shields.io/badge/Share-LinkedIn-blue)](https://www.linkedin.com/sharing/share-offsite/?url=https://github.com/tu-usuario/it-consulting-dashboard)

---

<div align="center">

**[⬆ Volver Arriba](#-it-consulting-dashboard---enterprise-support-platform)**

---

Made with ❤️ by [Bryan Martínez](https://github.com/bryanmartinez)

**🚀 Construido para Escalar | 💼 Diseñado para Profesionales | 🌟 Open Source Forever**

</div>
