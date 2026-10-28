-- Plugins remplacés, gardés actifs le temps de valider leurs remplaçants (voir docs/notes/).
-- Une fois validé : supprimer leur spec ici, puis `:Lazy clean`.

return {
  { -- Remplacé par snacks.picker (lua/plugins/snacks.lua). Ses pickers restent sous <leader>T pour comparer.
    -- https://github.com/nvim-telescope/telescope.nvim
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      -- Installé mais non chargé : vim.ui.select passe par snacks
      'nvim-telescope/telescope-ui-select.nvim',
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('telescope').setup {}
      pcall(require('telescope').load_extension, 'fzf')

      local builtin = require 'telescope.builtin'
      local map = vim.keymap.set
      map('n', '<leader>Tf', builtin.find_files, { desc = 'Fichiers' })
      map('n', '<leader>Tg', builtin.live_grep, { desc = 'Grep dans le projet' })
      map('n', '<leader>Tw', builtin.grep_string, { desc = 'Mot sous le curseur' })
      map('n', '<leader>Tb', builtin.buffers, { desc = 'Buffers' })
      map('n', '<leader>Tr', builtin.resume, { desc = 'Reprendre' })
      map('n', '<leader>Td', builtin.diagnostics, { desc = 'Diagnostics' })
      map('n', '<leader>Th', builtin.help_tags, { desc = 'Aide' })
      map('n', '<leader>Tk', builtin.keymaps, { desc = 'Keymaps' })
      map('n', '<leader>T.', builtin.oldfiles, { desc = 'Fichiers récents' })
      map('n', '<leader>Ts', builtin.builtin, { desc = 'Tous les pickers' })
    end,
  },

  { -- Sous tuios ($TMUX vide), il se comporte comme les mappings <C-hjkl> de config/keymaps.lua.
    -- https://github.com/christoomey/vim-tmux-navigator
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
      'TmuxNavigatorProcessList',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
  },
}
