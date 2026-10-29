-- Git dans la gouttière (gitsigns) et relecture des diffs (diffview).
-- Lazygit (`<leader>gg`) et les pickers git sont dans snacks.lua.

return {
  { -- Signes des lignes modifiées + actions hunk par hunk
    -- https://github.com/lewis6991/gitsigns.nvim
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gs = require 'gitsigns'
        local map = function(mode, keys, func, desc)
          vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
        end

        -- En mode diff, ]c / [c gardent leur sens natif
        map('n', ']h', function()
          gs.nav_hunk 'next'
        end, 'Hunk suivant')
        map('n', '[h', function()
          gs.nav_hunk 'prev'
        end, 'Hunk précédent')

        map('n', '<leader>hs', gs.stage_hunk, 'Stager / déstager le hunk')
        map('n', '<leader>hr', gs.reset_hunk, 'Annuler le hunk')
        map('v', '<leader>hs', function()
          gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, 'Stager la sélection')
        map('v', '<leader>hr', function()
          gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, 'Annuler la sélection')
        map('n', '<leader>hS', gs.stage_buffer, 'Stager le fichier')
        map('n', '<leader>hR', gs.reset_buffer, 'Annuler le fichier')
        map('n', '<leader>hp', gs.preview_hunk, 'Aperçu du hunk (popup)')
        map('n', '<leader>hi', gs.preview_hunk_inline, 'Aperçu du hunk (inline)')
        map('n', '<leader>hb', function()
          gs.blame_line { full = true }
        end, 'Blame de la ligne')
        map('n', '<leader>hd', gs.diffthis, 'Diff du fichier contre l’index')
        map('n', '<leader>tb', gs.toggle_current_line_blame, 'Afficher / masquer le blame de ligne')

        -- Text object : `ih` sélectionne le hunk (ex. `vih`, `dih`)
        map({ 'o', 'x' }, 'ih', gs.select_hunk, 'Hunk')
      end,
    },
  },

  { -- Diff côte à côte de tout le working tree, historique d'un fichier
    -- https://github.com/sindrets/diffview.nvim
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
    keys = {
      {
        '<leader>gd',
        function()
          if require('diffview.lib').get_current_view() then
            vim.cmd 'DiffviewClose'
          else
            vim.cmd 'DiffviewOpen'
          end
        end,
        desc = 'Diffview : ouvrir / fermer',
      },
      { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = 'Historique du fichier' },
      { '<leader>gH', '<cmd>DiffviewFileHistory<cr>', desc = 'Historique du dépôt' },
      { '<leader>gm', '<cmd>DiffviewOpen main...HEAD<cr>', desc = 'Diff de la branche contre main' },
    },
    opts = {},
  },
}
