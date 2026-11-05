#!/usr/bin/env bash
# install/install.sh
# Instala a skill "frontend-ui-inspection" (versao MCP) baixando APENAS
# os arquivos necessarios a partir do GitHub, SEM clonar o repositorio inteiro.
#
# Uso (sem clonar o repo):
#   curl -fsSL https://raw.githubusercontent.com/SoloLF17/frontend-ui-inspection-skill/main/install/install.sh | bash
# ou localmente (repo clonado):
#   bash install/install.sh
#
# Variaveis opcionais: REPO, BRANCH, SKILL_SUBPATH, SKILL_NAME, TARGET_BASE, BASE_URL
set -euo pipefail

REPO="${REPO:-SoloLF17/frontend-ui-inspection-skill}"
BRANCH="${BRANCH:-main}"
SKILL_SUBPATH="${SKILL_SUBPATH:-frontend-ui-inspection-skill}"
SKILL_NAME="${SKILL_NAME:-frontend-ui-inspection}"
TARGET_BASE="${TARGET_BASE:-$HOME/.config/opencode/skills}"
TARGET="$TARGET_BASE/$SKILL_NAME"

FILES=(
  "skill/frontend-ui-inspection/SKILL.md"
  "skill/frontend-ui-inspection/README.md"
  "agents/agent-integration.md"
  "config/opencode.config.snippet.json"
)

if ! command -v curl >/dev/null 2>&1; then
  echo "Erro: 'curl' nao encontrado." >&2
  exit 1
fi

BASE_URL="${BASE_URL:-https://raw.githubusercontent.com/${REPO}/${BRANCH}/${SKILL_SUBPATH}}"
echo "Baixando skill '${SKILL_NAME}' de ${REPO}@${BRANCH}/${SKILL_SUBPATH}..."
echo "Fonte: ${BASE_URL}"
echo "Destino: ${TARGET}"

for f in "${FILES[@]}"; do
  mkdir -p "$TARGET/$(dirname "$f")"
done
# normaliza destino (remove subdir 'skill/...' -> raiz da skill)
for f in "${FILES[@]}"; do
  :
done

# Baixa cada arquivo para o destino correspondente (achata skill/... para raiz)
for f in "${FILES[@]}"; do
  url="${BASE_URL}/${f}"
  # destino: se comeca com skill/<id>/, achata para a raiz da skill
  rel="${f#skill/frontend-ui-inspection/}"
  out="${TARGET}/${rel}"
  mkdir -p "$(dirname "$out")"
  echo "  -> ${rel}"
  if ! curl -fsSL "$url" -o "$out"; then
    echo "Erro ao baixar ${url}" >&2
    exit 1
  fi
done

cat <<EOF

Instalacao concluida em: ${TARGET}

Proximos passos:
  1. (OpenCode) Garanta o MCP 'browser' (Playwright) no ~/.config/opencode/opencode.json.
     Trecho: config/opencode.config.snippet.json (no repositorio).
  2. Reinicie o OpenCode.
  3. Chame: "Use a skill frontend-ui-inspection ...".

Nao foi baixado o repositorio inteiro; apenas os arquivos da skill.
EOF
