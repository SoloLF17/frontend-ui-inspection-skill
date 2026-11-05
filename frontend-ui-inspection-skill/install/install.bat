@echo off
where node >nul 2>&1
if errorlevel 1 (
  echo Node.js nao encontrado. Instale Node 18+ e tente novamente.
  pause
  exit /b 1
)
pushd "%~dp0"
node install.js
popd
pause
