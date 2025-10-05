# 🤝 Contributing to IT Consulting Dashboard

¡Gracias por tu interés en contribuir al proyecto! Toda ayuda es bienvenida.

## 📋 Tabla de Contenidos

- [Código de Conducta](#código-de-conducta)
- [Cómo Puedo Contribuir](#cómo-puedo-contribuir)
- [Proceso de Desarrollo](#proceso-de-desarrollo)
- [Guía de Estilo](#guía-de-estilo)
- [Reportar Bugs](#reportar-bugs)
- [Sugerir Features](#sugerir-features)

---

## 📜 Código de Conducta

Este proyecto se adhiere a un Código de Conducta. Al participar, se espera que mantengas un ambiente respetuoso y profesional.

### Nuestros Estándares

✅ **Hacer:**
- Usar lenguaje acogedor e inclusivo
- Respetar diferentes puntos de vista y experiencias
- Aceptar críticas constructivas con gracia
- Enfocarse en lo que es mejor para la comunidad
- Mostrar empatía hacia otros miembros

❌ **No Hacer:**
- Uso de lenguaje o imágenes sexualizadas
- Trolling, comentarios insultantes/despectivos
- Acoso público o privado
- Publicar información privada de otros sin permiso
- Conducta inapropiada en un entorno profesional

---

## 🎯 Cómo Puedo Contribuir

### 1. Reportar Bugs 🐛

Los bugs se rastrean como [GitHub Issues](issues). Antes de crear un issue:

1. **Busca** si ya existe un issue similar
2. **Verifica** que estás usando la última versión
3. **Incluye** información detallada:

**Template de Bug Report:**

```markdown
**Descripción del Bug**
[Descripción clara y concisa del bug]

**Pasos para Reproducir**
1. Ve a '...'
2. Haz clic en '...'
3. Scroll down a '...'
4. Ver error

**Comportamiento Esperado**
[Lo que debería pasar]

**Comportamiento Actual**
[Lo que realmente pasa]

**Screenshots**
[Si aplica, agrega screenshots]

**Entorno:**
 - OS: [e.g. Windows 11, macOS 14, Ubuntu 22.04]
 - Ruby version: [e.g. 3.2.2]
 - Rails version: [e.g. 8.0.2]
 - Browser: [e.g. Chrome 120, Firefox 121]

**Información Adicional**
[Cualquier otra info relevante]
```

### 2. Sugerir Features 💡

Las sugerencias de features también son GitHub Issues. Incluye:

**Template de Feature Request:**

```markdown
**¿Tu feature request está relacionado a un problema?**
[e.g. Siempre me frustra cuando...]

**Describe la solución que te gustaría**
[Descripción clara de lo que quieres que pase]

**Describe alternativas que has considerado**
[Otras soluciones o features que has pensado]

**Casos de Uso**
[Cómo usarías esta feature en tu día a día]

**Contexto Adicional**
[Screenshots, mockups, referencias a otras apps]
```

### 3. Contribuir Código 💻

#### Primera Vez Contribuyendo?

Busca issues etiquetados con:
- `good first issue` - Buenos para principiantes
- `help wanted` - Necesitamos ayuda
- `documentation` - Mejoras a la documentación

#### Proceso de Pull Request

1. **Fork** el repositorio
2. **Clone** tu fork:
   ```bash
   git clone https://github.com/TU-USUARIO/it-consulting-dashboard.git
   cd it-consulting-dashboard
   ```

3. **Crea una rama** desde `main`:
   ```bash
   git checkout -b feature/mi-nueva-feature
   # O para bug fixes:
   git checkout -b fix/descripcion-del-fix
   ```

4. **Instala dependencias**:
   ```bash
   bundle install
   rails db:create db:migrate db:seed
   ```

5. **Haz tus cambios**:
   - Escribe código limpio y legible
   - Sigue la guía de estilo de Rails
   - Agrega tests si aplica
   - Actualiza documentación si es necesario

6. **Prueba tus cambios**:
   ```bash
   rails test
   # O si usas RSpec:
   bundle exec rspec
   ```

7. **Commit** tus cambios:
   ```bash
   git add .
   git commit -m "feat: Add email notifications for SLA breaches"
   ```

   **Formato de Commits:**
   - `feat:` Nueva feature
   - `fix:` Bug fix
   - `docs:` Cambios en documentación
   - `style:` Formato (sin cambios de código)
   - `refactor:` Refactorización
   - `test:` Agregar tests
   - `chore:` Mantenimiento

8. **Push** a tu fork:
   ```bash
   git push origin feature/mi-nueva-feature
   ```

9. **Crea Pull Request** en GitHub:
   - Título claro y descriptivo
   - Descripción detallada de los cambios
   - Referencia issues relacionados (#123)
   - Incluye screenshots si hay cambios visuales

---

## 🛠️ Proceso de Desarrollo

### Estructura del Proyecto

```
it-consulting-dashboard/
├── app/
│   ├── controllers/    # Lógica de controladores
│   ├── models/         # Modelos ActiveRecord
│   ├── views/          # Vistas ERB
│   └── helpers/        # Helper methods
├── config/             # Configuración
├── db/                 # Migraciones y seeds
├── docs/               # Documentación
└── spec/               # Tests (si usas RSpec)
```

### Setup Local

```bash
# 1. Instalar dependencias
bundle install

# 2. Configurar base de datos
rails db:create
rails db:migrate
rails db:seed

# 3. Compilar assets
rails tailwindcss:build

# 4. Iniciar servidor
bin/dev
# O:
rails server
```

### Ejecutar Tests

```bash
# Todos los tests
rails test

# Tests específicos
rails test test/models/ticket_test.rb

# Con RSpec
bundle exec rspec
bundle exec rspec spec/models/ticket_spec.rb
```

---

## 📏 Guía de Estilo

### Ruby / Rails

Seguimos la [Ruby Style Guide](https://rubystyle.guide/) y [Rails Style Guide](https://rails.rubystyle.guide/).

**Principales reglas:**

```ruby
# ✅ Bueno
class TicketsController < ApplicationController
  def index
    @tickets = Ticket.includes(:client, :assigned_to)
                     .where(status: params[:status])
                     .page(params[:page])
  end
end

# ❌ Malo
class TicketsController < ApplicationController
  def index
    @tickets=Ticket.all
    if params[:status]
      @tickets=@tickets.where(status: params[:status])
    end
  end
end
```

### ERB / Views

```erb
<!-- ✅ Bueno -->
<% @tickets.each do |ticket| %>
  <div class="ticket-card">
    <%= link_to ticket.title, ticket_path(ticket) %>
  </div>
<% end %>

<!-- ❌ Malo -->
<%@tickets.each do |ticket|%>
<div class="ticket-card">
<%=link_to ticket.title,ticket_path(ticket)%>
</div>
<%end%>
```

### Tailwind CSS

```erb
<!-- ✅ Bueno - Clases ordenadas lógicamente -->
<div class="flex items-center justify-between p-4 bg-[#161b22] border border-[#30363d] rounded-lg">

<!-- ❌ Malo - Desorganizado -->
<div class="p-4 border-[#30363d] bg-[#161b22] rounded-lg justify-between items-center border flex">
```

### Commits

```bash
# ✅ Bueno
feat: Add email notifications for SLA breaches

Implements automatic email notifications when tickets are
approaching SLA deadline (30 min before).

- Created EmailNotificationJob
- Added TicketMailer with sla_warning template
- Updated Ticket model with notification logic
- Added Sidekiq configuration

Closes #45

# ❌ Malo
update files
```

---

## 🧪 Testing

### Escribir Tests

```ruby
# test/models/ticket_test.rb
require 'test_helper'

class TicketTest < ActiveSupport::TestCase
  test "should not save ticket without title" do
    ticket = Ticket.new
    assert_not ticket.save, "Saved the ticket without a title"
  end

  test "should calculate MTTR correctly" do
    ticket = tickets(:one)
    ticket.update(
      created_at: 2.hours.ago,
      resolved_at: Time.current
    )
    assert_equal 120, ticket.response_time_minutes
  end
end
```

---

## 📝 Documentación

### Comentarios en Código

```ruby
# ✅ Bueno - Explica el "por qué"
# Necesitamos eager load para evitar N+1 queries
# cuando mostramos el nombre del cliente en la vista
@tickets = Ticket.includes(:client)

# ❌ Malo - Explica el "qué" (obvio)
# Cargar tickets con cliente
@tickets = Ticket.includes(:client)
```

### Actualizar README

Si tu PR agrega una feature nueva:
1. Actualiza la sección de Features
2. Actualiza el Quick Start si es necesario
3. Agrega ejemplos de uso

---

## 🎨 Contribuciones Específicas

### Frontend / UI

- Mantén el dark theme consistente
- Asegúrate que sea responsive
- Usa los colores de la paleta:
  - `#0d1117` - Background
  - `#161b22` - Secondary BG
  - `#58a6ff` - Accent blue
  - `#7ee787` - Success green
  - `#f85149` - Error red

### Backend / API

- Mantén los controllers RESTful
- Usa concerns para código compartido
- Agrega validaciones apropiadas
- Optimiza queries (usa `includes`, `joins`)

### Base de Datos

- Crea migraciones reversibles
- Agrega índices para queries frecuentes
- Documenta cambios de schema

### Documentación

- Escribe en español e inglés cuando sea posible
- Usa ejemplos concretos
- Incluye screenshots si es relevante

---

## ✅ Checklist del PR

Antes de abrir tu Pull Request, verifica:

- [ ] El código sigue la guía de estilo
- [ ] Has agregado tests (si aplica)
- [ ] Los tests pasan localmente
- [ ] Has actualizado la documentación
- [ ] El commit message es descriptivo
- [ ] Has testeado en development
- [ ] No hay warnings o deprecations
- [ ] Has actualizado el CHANGELOG (si aplica)

---

## 🚀 Después del PR

1. Un maintainer revisará tu PR
2. Puede haber comentarios o solicitudes de cambios
3. Haz los cambios solicitados y push nuevamente
4. Una vez aprobado, será merged
5. ¡Gracias por tu contribución! 🎉

---

## 💬 Comunidad

### Dónde Obtener Ayuda

- 📖 [Documentación](README.md)
- 💬 [GitHub Discussions](discussions)
- 🐛 [GitHub Issues](issues)
- 📧 Email: bryan.martinez@example.com

### Reconocimiento

Todos los contribuidores serán:
- Listados en el README
- Mencionados en el CHANGELOG
- Agradecidos en las notas de release

---

## 📄 Licencia

Al contribuir, aceptas que tus contribuciones serán licenciadas bajo la [MIT License](LICENSE).

---

**¡Gracias por hacer este proyecto mejor!** 🙌

Si tienes preguntas sobre cómo contribuir, no dudes en abrir un issue o contactarnos directamente.
