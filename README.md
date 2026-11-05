# Frontend UI Inspection — skill + instalacao (pacote unificado)

## Parte 1 — O que e a skill e como funciona

# Frontend UI Inspection — skill de edições assistidas pela tela

## Em uma frase
Essa skill ajuda o agente de IA a **"ver" sua interface** (através do navegador ou de um print) e depois **achar e editar o código certo**, sem você precisar colar HTML inteiro nem adivinhar nomes de arquivos.

## O que ela facilita

- Editar o frontend (botões, cores, textos, layout) de forma direcionada.
- Encontrar qual arquivo/linha está por trás do que aparece na tela.
- Validar se a mudança deu certo (console, rede, visual).
- Escolher entre dois modos conforme a situação.

## Visão geral dos dois modos

| Modo | Nome | Quando usar | Você precisa fazer |
|---|---|---|---|
| A | Navegador automatizado | Desenvolvimento local | Rodar o app (ex.: `npm run dev`) e me passar a URL |
| B | Print salvo em arquivo | Bug em produção/staging, ou página protegida | Tirar um print da região e salvar em `/tmp/opencode/ui-*.png` |

## Antes de começar (requisitos)

- Modo A: precisa de dev server (ex.: `http://localhost:3000`) e o MCP `browser` instalado (já configurado: ver `~/.config/opencode/opencode.json`).
- Modo B: só precisa salvar o print no caminho combinado.
- Toute análise visual usa um **subagente com visão**, porque o modelo principal não "lê" imagens.

## Passo a passo — Modo A (navegador)

1. Você diz: *"Edite o botão Entrar na home"*.
2. Eu confirmo a URL (ex.: `http://localhost:3000/`).
3. Eu abro a página no navegador automatizado.
4. Leio a estrutura (DOM) para localizar o elemento.
5. Tiro screenshot e peço a um subagente de visão para descrevê-lo.
6. Localizo os arquivos candidatos no código.
7. Proponho o diff e, após seu "ok", aplico.
8. Recarrego a página e verifico console/rede/visual.

### Exemplo real (testado nesta máquina)

- URL pública `https://example.com` foi aberta.
- Snapshot retornou o texto "This domain is for use in documentation examples...".
- Screenshot salvo e descrito: layout centralizado, texto multilíngue, link "Learn more".
- Console: 0 erros.

## Passo a passo — Modo B (print salvo)

1. Você tira um print da área (de preferência só a região).
2. Marca/circula o alvo (seta/retângulo vermelho).
3. Salva em `/tmp/opencode/ui-<label>.png` (ex.: `ui-header-botao-entrar.png`).
4. Você me avisa: *"Olhe /tmp/opencode/ui-header-botao-entrar.png"*.
5. Eu peço a um subagente de visão para descrever o que está na imagem.
6. Busco a frase/texto/classe no código (`grep`/`glob`).
7. Proponho/edito o arquivo certo.

### Exemplo real (testado nesta máquina)

- Arquivo `/tmp/opencode/ui-example-mode-b.png` foi lido com sucesso.
- Descrição: página de exemplo, texto multilíngue e link "Learn more".
- Conclusão: "CAMINHO: OK".

## Dicas para aumentar acerto (leigo-friendly)

- **Recorte só a região**; menos ruído.
- **Deixe um elemento de referência visível** (logo/header) para orientar.
- Se possível, cole `outerHTML` (DevTools: copiar elemento) junto com o print.
- Nomeie o print com o alvo: `ui-header-botao-entrar.png`.

## Limitações (o que NÃO acontece)

- O agente **não controla seu mouse/desktop** nem compartilha seus cookies/logins do Chrome.
- O modelo principal **não "vê" imagens**; toda visão passa por subagente.
- Sem dev server, o Modo A não roda (use Modo B).

## Segurança

- Nunca forneça credenciais de produção. Use staging ou URLs já autenticadas.
- Antes de cliques destrutivos (logout/delete/submit), o agente pede confirmação.

## Como chamar a skill

Em uma conversa, mencione: *"Use a skill frontend-ui-inspection para editar o botão Entrar na home."*

## Checklist rápido (self-test)

- [ ] `opencode mcp list` mostra `browser` (pode estar "pending" até a primeira chamada).
- [ ] `browser_navigate` abre uma URL e `browser_snapshot` retorna texto.
- [ ] `browser_take_screenshot` salva PNG (padrão em `.playwright-mcp/`).
- [ ] Subagente de visão descreve o PNG.
- [ ] Print em `/tmp/opencode/ui-test.png` é descrito corretamente.

## Status

Skill instalada em `~/.config/opencode/skills/frontend-ui-inspection/SKILL.md`.
Ambos os modos testados com sucesso nesta máquina em 2026-11-05.

## Parte 2 — Como instalar

### Instalacao automatica (OpenCode)

**macOS/Linux**
```bash
bash install/install.sh
```

**Windows (PowerShell)**
```powershell
powershell -ExecutionPolicy Bypass -File install\install.ps1
```

**Windows (sem PowerShell)**
```bat
install\install.bat
```

O instalador:
- Copia `skill/frontend-ui-inspection` para `~/.config/opencode/skills/frontend-ui-inspection` (ou `%USERPROFILE%\.config\opencode\skills\frontend-ui-inspection` no Windows).
- Adiciona o MCP `browser` (Playwright) no `opencode.json`, se ainda nao existir.
- Adiciona permissao `browser_*: allow`.
- Faz backup da config original.

Reinicie o OpenCode apos instalar.

### Outros agentes
Veja `agents/agent-integration.md` (Claude Code, Cursor, Codex, chat generico).

### Conteudo do pacote
- `skill/` — skill + README
- `agents/` — integracao por agente
- `install/` — instaladores (js/sh/ps1/bat)
- `examples/` — exemplos de codigo
- `test/` — relato de teste
- `config/` — snippet de configuracao
