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
    enabled = false, -- désactivé par défaut, activer avec <leader>tm

    completions = { lsp = { enabled = true } },

    heading = {
      position = 'inline', -- icône à gauche (défaut: 'overlay')
      width = 'block', -- le fond couvre le texte, pas toute la ligne
      left_pad = 1,
      right_pad = 2,
      border = true, -- barres ▄ / ▀ autour des titres
      border_virtual = true,
      icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
    },

    code = {
      style = 'full', -- icône + nom du langage
      width = 'block', -- fond limité à la largeur du code
      left_pad = 2,
      right_pad = 2,
      border = 'thick',
      language_name = true,
    },

    bullet = { icons = { '●', '○', '◆', '◇' } },

    checkbox = {
      unchecked = { icon = '󰄱 ' },
      checked = { icon = '󰱒 ' },
      custom = { todo = { raw = '[-]', rendered = '󰥔 ', highlight = 'RenderMarkdownTodo' } },
    },

    pipe_table = { preset = 'round' }, -- coins arrondis ('heavy' et 'double' existent aussi)

    indent = { enabled = true }, -- indente le contenu sous chaque titre

    anti_conceal = { enabled = true }, -- montre la source sur la ligne du curseur
  },
  keys = {
    { '<leader>tm', '<cmd>RenderMarkdown toggle<cr>', ft = 'markdown', desc = 'Rendu Markdown on/off' },
    { '<leader>tM', mermaid_pane, ft = 'markdown', desc = 'Diagrammes Mermaid (pane tuios)' },
  },
}
