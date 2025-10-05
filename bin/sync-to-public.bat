@echo off
REM Script para sincronizar código del repositorio privado al público (Windows)
REM Uso: .\bin\sync-to-public.bat

echo 🔄 Sincronizando repositorio privado → público...

set PUBLIC_REPO=..\it-consulting-dashboard-public

if not exist "%PUBLIC_REPO%" (
    echo ❌ Error: No se encuentra el repositorio público en %PUBLIC_REPO%
    exit /b 1
)

echo 📦 Copiando archivos...

REM Copiar todos los archivos
xcopy /E /Y /I /Q . "%PUBLIC_REPO%" > nul

REM Limpiar archivos sensibles del repo público
if exist "%PUBLIC_REPO%\.env" del "%PUBLIC_REPO%\.env"
if exist "%PUBLIC_REPO%\.env.local" del "%PUBLIC_REPO%\.env.local"
if exist "%PUBLIC_REPO%\config\master.key" del "%PUBLIC_REPO%\config\master.key"
if exist "%PUBLIC_REPO%\storage\" rmdir /S /Q "%PUBLIC_REPO%\storage"
if exist "%PUBLIC_REPO%\tmp\" rmdir /S /Q "%PUBLIC_REPO%\tmp"
if exist "%PUBLIC_REPO%\log\" rmdir /S /Q "%PUBLIC_REPO%\log"

REM Recrear directorios vacíos con .keep
mkdir "%PUBLIC_REPO%\storage" 2>nul
mkdir "%PUBLIC_REPO%\tmp" 2>nul
mkdir "%PUBLIC_REPO%\log" 2>nul
echo. > "%PUBLIC_REPO%\storage\.keep"
echo. > "%PUBLIC_REPO%\tmp\.keep"
echo. > "%PUBLIC_REPO%\log\.keep"

cd "%PUBLIC_REPO%"

echo.
echo 🔍 Verificando cambios...
git status

echo.
echo ✅ Archivos sincronizados exitosamente
echo.
echo Próximos pasos:
echo 1. cd %PUBLIC_REPO%
echo 2. git add -A
echo 3. git commit -m "Release vX.X.X - Descripción"
echo 4. git push origin main
echo.
echo ⚠️  IMPORTANTE: Revisa los cambios antes de hacer commit
