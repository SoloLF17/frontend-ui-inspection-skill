const fs = require('fs');
const path = require('path');
const os = require('os');

const skillId = 'frontend-ui-inspection';
const pkgRoot = path.resolve(__dirname, '..');
const skillSrc = path.join(pkgRoot, 'skill', skillId);
const targetSkillDir = path.join(os.homedir(), '.config', 'opencode', 'skills', skillId);
const configPath = path.join(os.homedir(), '.config', 'opencode', 'opencode.json');

function copyDir(src, dst) {
  fs.mkdirSync(dst, { recursive: true });
  for (const entry of fs.readdirSync(src, { withFileTypes: true })) {
    const s = path.join(src, entry.name);
    const d = path.join(dst, entry.name);
    if (entry.isDirectory()) copyDir(s, d);
    else fs.copyFileSync(s, d);
  }
}

function main() {
  console.log('Instalando skill:', skillId);
  copyDir(skillSrc, targetSkillDir);
  console.log('Skill copiada para:', targetSkillDir);

  let cfg = {};
  if (fs.existsSync(configPath)) {
    try { cfg = JSON.parse(fs.readFileSync(configPath, 'utf8')); }
    catch (err) { console.error('Config JSON invalida, abortando merge:', err.message); process.exit(1); }
    const backup = configPath + '.bak.' + Date.now();
    fs.copyFileSync(configPath, backup);
    console.log('Backup da config:', backup);
  } else {
    fs.mkdirSync(path.dirname(configPath), { recursive: true });
  }

  cfg.mcp = cfg.mcp || {};
  cfg.mcp.servers = cfg.mcp.servers || {};
  if (!cfg.mcp.servers.browser) {
    cfg.mcp.servers.browser = { type: 'local', command: ['npx', '-y', '@playwright/mcp@latest'] };
    console.log('MCP "browser" adicionado.');
  } else {
    console.log('MCP "browser" ja existia; mantido.');
  }

  cfg.permissions = Array.isArray(cfg.permissions) ? cfg.permissions : [];
  const hasBrowserAllow = cfg.permissions.some(p => p.action === 'browser_*' && p.effect === 'allow');
  if (!hasBrowserAllow) {
    cfg.permissions.unshift({ action: 'browser_*', resource: '*', effect: 'allow' });
    console.log('Permissao browser_* adicionada.');
  }

  fs.writeFileSync(configPath, JSON.stringify(cfg, null, 2) + '\n');
  console.log('Config atualizada:', configPath);
  console.log('Reinicie o OpenCode para carregar a skill e o MCP.');
}
main();
