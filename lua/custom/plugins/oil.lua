-- File explorer plugin
-- https://github.com/stevearc/oil.nvim
return {
  'stevearc/oil.nvim',
  opts = {},
  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('oil').setup {
      -- To see all options, run `:help oil-options`
      default_file_explorer = true,
      -- Use `-` to open oil in the current window
      keymaps = {
        ['<leader>-'] = 'actions.open_cwd',
        ['g.'] = { 'actions.toggle_hidden', mode = 'n' },
      },
    }

    -- Open parent directory in oil
    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
  end,
}
