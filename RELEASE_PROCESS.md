# 📦 Proceso de Release al Repositorio Público

Este documento describe cómo publicar una nueva versión del código al repositorio público sin exponer información sensible.

## 🔒 Archivos que NUNCA se publican

Los siguientes archivos están excluidos automáticamente:
- `.env` - Variables de entorno locales
- `.env.local` - Configuración local
- `config/master.key` - Llave maestra de Rails
- `storage/` - Archivos subidos
- `tmp/`, `log/` - Archivos temporales
- `.git/` - Historial de git privado

## 🚀 Proceso de Release

### Opción 1: Script Automático (Recomendado)

```bash
# 1. Desde el repositorio privado
./bin/sync-to-public.sh

# 2. Ir al repositorio público
cd ../it-consulting-dashboard-public

# 3. Revisar cambios
git status
git diff

# 4. Crear commit de release
git add -A
git commit -m "Release v1.1.0 - Descripción de cambios"

# 5. Pushear
git push origin main
```

### Opción 2: Manual

```bash
# 1. Ir al repositorio público
cd ../it-consulting-dashboard-public

# 2. Copiar archivos manualmente (excepto sensibles)
# Asegúrate de NO copiar:
# - .env
# - config/master.key
# - storage/
# - tmp/, log/

# 3. Commit y push
git add -A
git commit -m "Release vX.X.X - Descripción"
git push origin main
```

## ✅ Checklist Antes de Publicar

- [ ] Revisar que NO haya credenciales hardcodeadas en el código
- [ ] Verificar que `.env` no esté en el commit
- [ ] Verificar que `config/master.key` no esté en el commit
- [ ] Actualizar versión en README si aplica
- [ ] Probar que el código funcione sin archivos sensibles
- [ ] Revisar `git diff` antes del commit

## 🏷️ Versionamiento

Usar Semantic Versioning (semver):
- **MAJOR.MINOR.PATCH** (ej: 1.2.3)
- MAJOR: Cambios incompatibles
- MINOR: Nueva funcionalidad compatible
- PATCH: Corrección de bugs

Ejemplos:
- `v1.0.0` - Release inicial
- `v1.1.0` - Nueva característica (sidebar counters)
- `v1.1.1` - Bug fix (responsive mobile)

## 📝 Mensaje de Commit Sugerido

```
Release v1.1.0 - Mejoras de UI/UX

Cambios principales:
- ✨ Agrega contadores dinámicos en sidebar
- 📱 Implementa diseño responsive para móvil
- 🎨 Rediseña pantalla de login
- 🐛 Corrige bugs menores

Demo: https://it-consulting-dashboard.onrender.com
```

## 🔄 Workflow Recomendado

1. **Desarrollo** → Repositorio privado (commits frecuentes)
2. **Testing** → Probar en local/staging
3. **Release** → Sincronizar al repositorio público (commits limpios)
4. **Tag** → Crear tag de versión en ambos repos

## 🚨 En caso de Exposición Accidental

Si accidentalmente publicas información sensible:

```bash
# 1. Revertir el commit público inmediatamente
cd ../it-consulting-dashboard-public
git revert HEAD
git push origin main

# 2. Rotar credenciales expuestas
# - Cambiar passwords
# - Regenerar SENTRY_DSN
# - Regenerar RAILS_MASTER_KEY

# 3. Force push si es necesario (con cuidado)
git reset --hard HEAD~1
git push origin main --force
```

## 📞 Soporte

Para dudas sobre el proceso de release, revisar este documento o contactar al maintainer.
