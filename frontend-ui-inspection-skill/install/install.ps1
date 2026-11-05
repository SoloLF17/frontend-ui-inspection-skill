if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
  Write-Host "Node.js nao encontrado. Instale Node 18+ e tente novamente."
  exit 1
}
node "$PSScriptRoot/install.js"
