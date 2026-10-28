-- Autocommandes et comportement au démarrage.

-- Surligne brièvement le texte copié
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Surligner le texte copié',
  group = vim.api.nvim_create_augroup('config-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
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
