-- oil.nvim : un dossier s'édite comme un buffer texte. Renommer = éditer la ligne, déplacer =
-- couper/coller la ligne dans un autre dossier, supprimer = dd. `:w` applique les changements.
-- Doc : https://github.com/stevearc/oil.nvim (`g?` dans oil pour l'aide)

return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('oil').setup {
      default_file_explorer = true, -- `nvim .` et `:e dossier/` ouvrent oil
      keymaps = {
        ['<leader>-'] = 'actions.open_cwd',
        ['g.'] = { 'actions.toggle_hidden', mode = 'n' },
      },
      view_options = { show_hidden = true },
    }

    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Dossier du fichier courant (oil)' })
  end,
}
