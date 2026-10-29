-- Apparence et aides visuelles : thème, aide-mémoire des touches, commentaires TODO.

return {
  { -- Thème : Ayu Dark, comme dans Zed. Essayer un autre thème : `<leader>sC`.
    -- https://github.com/Shatur/neovim-ayu
    'Shatur/neovim-ayu',
    priority = 1000, -- chargé avant les autres plugins
    config = function()
      require('ayu').setup { mirage = false }
      vim.cmd.colorscheme 'ayu-dark'
    end,
  },

  { -- Bordure colorée autour du pane actif (les autres séparateurs restent discrets)
    -- https://github.com/nvim-zh/colorful-winsep.nvim (`:Winsep toggle`)
    'nvim-zh/colorful-winsep.nvim',
    event = 'WinLeave', -- inutile tant qu'il n'y a qu'un pane
    opts = {
      border = 'single', -- trait fin (bold : trait épais)
      highlight = '#E6B450', -- accent Ayu
      animate = { enabled = false },
      excluded_ft = { 'snacks_picker_list', 'snacks_picker_input', 'snacks_layout_box' },
    },
  },

  { -- Icônes de fichiers (picker, explorer, statusline). Nécessite une Nerd Font.
    -- https://github.com/nvim-tree/nvim-web-devicons
    'nvim-tree/nvim-web-devicons',
    lazy = true,
    enabled = vim.g.have_nerd_font,
  },

  { -- Ancien thème, gardé installé pour comparer (`:colorscheme tokyonight-night`)
    -- https://github.com/folke/tokyonight.nvim
    'folke/tokyonight.nvim',
    lazy = true,
    opts = { styles = { comments = { italic = false } } },
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
