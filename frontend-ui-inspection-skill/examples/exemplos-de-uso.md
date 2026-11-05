# Exemplos de uso (código das ferramentas)

## Modo A — navegador automatizado

```js
await tools.browser.browser_navigate({ url: "http://localhost:3000/" });
await tools.browser.browser_snapshot({ boxes: true });
await tools.browser.browser_find({ text: "Entrar" });
await tools.browser.browser_evaluate({
  target: "<ref-do-snapshot>",
  function: "(el) => ({ tag: el.tagName, classes: el.className, html: el.outerHTML, styles: getComputedStyle(el).cssText })"
});
await tools.browser.browser_take_screenshot({ fullPage: false, scale: "css", filename: "ui-header.png" });
await tools.browser.browser_console_messages({ level: "error" });
await tools.browser.browser_network_requests({ static: false, filter: "/api" });
```

## Descrição visual (subagente de visão)

```js
subagent({
  agent: "general",
  model: "opencode/nemotron-3.5-super-vl-free",
  description: "Descrever screenshot UI",
  prompt: "Leia o arquivo ./ui-header.png e descreva em PT-BR layout, textos, cores e problemas. 8 bullets no máximo."
});
```

## Modo B — print salvo em arquivo

```js
subagent({
  agent: "general",
  model: "opencode/nemotron-3.5-super-vl-free",
  description: "Ler print UI",
  prompt: "Leia /tmp/opencode/ui-header.png. Descreva em PT-BR texto/botões, layout, cores e elemento circulado. Termine com 'ELEMENTO_ALVO: ...'."
});
```
