#!/usr/bin/env bash
set -euo pipefail
if ! command -v node >/dev/null 2>&1; then
  echo "Node.js nao encontrado. Instale Node 18+ e tente novamente."
  exit 1
fi
node "$(dirname "$0")/install.js"
