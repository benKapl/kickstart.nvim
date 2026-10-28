-- Apparence et aides visuelles : thème, aide-mémoire des touches, commentaires TODO.

return {
  { -- Thème. Changer de thème : `<leader>sC` (picker des colorschemes) puis l'ajouter ici.
    -- https://github.com/folke/tokyonight.nvim
    'folke/tokyonight.nvim',
    priority = 1000, -- chargé avant les autres plugins
    config = function()
      require('tokyonight').setup {
        styles = { comments = { italic = false } },
      }
      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },

  { -- Affiche les suites possibles d'un raccourci en cours de frappe (appuyer sur <leader> et attendre)
    -- https://github.com/folke/which-key.nvim
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 0,
      icons = { mappings = vim.g.have_nerd_font },
      spec = {
        { '<leader>s', group = 'Recherche' },
        { '<leader>g', group = 'Git' },
        { '<leader>t', group = 'Toggle' },
        { '<leader>h', group = 'Hunk git', mode = { 'n', 'v' } },
        { '<leader>R', group = 'Requêtes HTTP (kulala)' },
      },
    },
  },

  { -- Surligne TODO, FIXME, NOTE… dans les commentaires
    -- https://github.com/folke/todo-comments.nvim
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
}
