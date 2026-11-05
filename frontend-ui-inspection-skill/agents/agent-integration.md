# Integração por agente

## OpenCode (recomendado)
1. Copie a pasta `skill/frontend-ui-inspection` para:
   - Linux/macOS: `~/.config/opencode/skills/frontend-ui-inspection`
   - Windows: `%USERPROFILE%\.config\opencode\skills\frontend-ui-inspection`
2. Junte `config/opencode.config.snippet.json` em `opencode.json` (permission + MCP `browser`).
3. Reinicie o OpenCode.
4. Chame: "Use a skill frontend-ui-inspection ...".

## Instalação automática
- macOS/Linux: `bash install/install.sh`
- Windows: `powershell -ExecutionPolicy Bypass -File install/install.ps1`

## Claude Code
- Arquivo de contexto global: `~/.claude/CLAUDE.md` (ou por projeto `./CLAUDE.md`).
- Anexe o conteúdo de `skill/frontend-ui-inspection/SKILL.md` ao final.
- Para regras de projeto: `.claude/rules/frontend-ui-inspection.md`.
- MCP browser precisa estar configurado conforme docs do Claude Code (não incluído).

## Cursor
- Crie `.cursor/rules/frontend-ui-inspection.mdc` no projeto e cole o conteúdo de `SKILL.md`.

## Codex / AGENTS.md
- Anexe `SKILL.md` ao `AGENTS.md` da raiz do repositório.

## Chat genérico (ChatGPT/Claude.ai etc.)
- Cole `README.md` + `SKILL.md` como system prompt/contexto.

## Observação
A skill depende da ferramenta Playwright MCP para automação. Em agentes sem suporte a MCP, use o Modo B (print salvo + descrição por modelo de visão).
