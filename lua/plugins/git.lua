-- Git dans la gouttière : signes des lignes ajoutées / modifiées / supprimées.
-- Doc : https://github.com/lewis6991/gitsigns.nvim
-- Lazygit (`<leader>gg`) et les pickers git sont dans snacks.lua.

return {
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
  },
}
