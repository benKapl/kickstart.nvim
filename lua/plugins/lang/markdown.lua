-- Markdown : rendu dans le buffer (titres, tableaux, listes, blocs de code, cases à cocher).
-- Le rendu s'efface sur la ligne du curseur pour éditer. Doc : `:help render-markdown`
-- https://github.com/MeanderingProgrammer/render-markdown.nvim
--
-- Diagrammes Mermaid : <leader>tM ouvre un pane tuios à côté qui dessine les blocs mermaid du fichier
-- (`tuios mermaid --watch`) et les redessine à chaque :w. `q` dans le pane le ferme.

-- Ouvre `tuios mermaid --watch` sur le fichier courant dans un nouveau pane tuios, sans prendre le focus
local function mermaid_pane()
  if not vim.env.TUIOS_SESSION then
    return vim.notify('Pas dans une session tuios', vim.log.levels.WARN)
  end
  local file = vim.fn.expand '%:p'
  vim.system({ 'tuios', 'new-window', 'mermaid', '--no-focus', '--', 'tuios', 'mermaid', '--watch', file }, {}, function(res)
    if res.code ~= 0 then
      vim.schedule(function()
        vim.notify('tuios mermaid : ' .. vim.trim(res.stderr or ''), vim.log.levels.ERROR)
      end)
    end
  end)
end

return {
  'MeanderingProgrammer/render-markdown.nvim',
  ft = { 'markdown' },
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    completions = { lsp = { enabled = true } }, -- complétion des cases à cocher et des callouts
  },
  keys = {
    { '<leader>tm', '<cmd>RenderMarkdown toggle<cr>', ft = 'markdown', desc = 'Rendu Markdown on/off' },
    { '<leader>tM', mermaid_pane, ft = 'markdown', desc = 'Diagrammes Mermaid (pane tuios)' },
  },
}
