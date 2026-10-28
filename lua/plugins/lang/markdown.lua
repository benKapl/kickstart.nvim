-- Markdown : rendu dans le buffer (titres, tableaux, listes, blocs de code, cases à cocher).
-- Le rendu s'efface sur la ligne du curseur pour éditer. Doc : `:help render-markdown`
-- https://github.com/MeanderingProgrammer/render-markdown.nvim

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
  },
}
