#!/usr/bin/env bash
# Script para sincronizar código del repositorio privado al público
# Uso: ./bin/sync-to-public.sh

set -e

echo "🔄 Sincronizando repositorio privado → público..."

# Directorio del repo público
PUBLIC_REPO="../it-consulting-dashboard-public"

# Verificar que existe el repo público
if [ ! -d "$PUBLIC_REPO" ]; then
  echo "❌ Error: No se encuentra el repositorio público en $PUBLIC_REPO"
  exit 1
fi

echo "📦 Copiando archivos..."

# Copiar archivos (excluyendo git y archivos sensibles)
rsync -av --delete \
  --exclude='.git' \
  --exclude='.env' \
  --exclude='.env.local' \
  --exclude='.env.*.local' \
  --exclude='config/master.key' \
  --exclude='storage/' \
  --exclude='tmp/' \
  --exclude='log/' \
  --exclude='node_modules/' \
  --exclude='.DS_Store' \
  ./ "$PUBLIC_REPO/"

cd "$PUBLIC_REPO"

echo "🔍 Verificando cambios..."
git status

echo ""
echo "✅ Archivos sincronizados exitosamente"
echo ""
echo "Próximos pasos:"
echo "1. cd $PUBLIC_REPO"
echo "2. git add -A"
echo "3. git commit -m 'Release vX.X.X - Descripción'"
echo "4. git push origin main"
echo ""
echo "⚠️  IMPORTANTE: Revisa los cambios antes de hacer commit"
