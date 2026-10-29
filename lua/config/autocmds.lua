-- Autocommandes et comportement au démarrage.

-- Surligne brièvement le texte copié
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Surligner le texte copié',
  group = vim.api.nvim_create_augroup('config-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Repérer le pane actif. Réappliqué à chaque changement de thème, qui écrase les surbrillances.
-- La bordure du pane actif vient de colorful-winsep (lua/plugins/ui.lua).
vim.api.nvim_create_autocmd('ColorScheme', {
  desc = 'Surbrillances du pane actif',
  group = vim.api.nvim_create_augroup('config-active-pane', { clear = true }),
  callback = function()
    vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#1C222B' }) -- séparateurs inactifs discrets
    vim.api.nvim_set_hl(0, 'NormalNC', { bg = '#0F131A' }) -- panes inactifs un peu plus clairs (panel_bg Ayu)
    -- Ligne du fichier courant dans l'explorer (son curseur suit le pane actif)
    vim.api.nvim_set_hl(0, 'SnacksPickerListCursorLine', { bg = '#9E2B33', bold = true }) -- rouge franc
    vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#9E2B33' }) --rouge franc
  end,
})

-- Ligne du curseur seulement dans le pane actif. Limité aux buffers de fichiers : l'explorer garde
-- la sienne, qui marque le fichier courant.
vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter', 'WinLeave' }, {
  desc = 'cursorline seulement dans le pane actif',
  group = vim.api.nvim_create_augroup('config-active-cursorline', { clear = true }),
  callback = function(ev)
    if vim.bo.buftype == '' then
      vim.wo.cursorline = ev.event ~= 'WinLeave'
    end
  end,
})

-- Serveur par session tuios : `e fichier` (bin/e), lancé depuis un autre pane de la session,
-- ouvre le fichier dans ce nvim. Le premier nvim de la session prend le socket ; les suivants l'ignorent.
local session = vim.env.TUIOS_SESSION
if session and session ~= '' then
  local sock = (vim.env.XDG_RUNTIME_DIR or '/tmp') .. '/nvim-' .. session .. '.sock'
  if vim.uv.fs_stat(sock) then
    local ok, chan = pcall(vim.fn.sockconnect, 'pipe', sock, { rpc = true })
    if ok and chan > 0 then
      vim.fn.chanclose(chan) -- un autre nvim de la session écoute déjà
      sock = nil
    else
      os.remove(sock) -- socket orphelin d'un nvim qui a planté
    end
  end
  if sock then
    pcall(vim.fn.serverstart, sock)
  end
end
