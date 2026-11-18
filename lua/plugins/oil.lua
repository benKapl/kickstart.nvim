-- oil.nvim : un dossier s'édite comme un buffer texte. Renommer = éditer la ligne, déplacer =
-- couper/coller la ligne dans un autre dossier, supprimer = dd. `:w` applique les changements.
-- Doc : https://github.com/stevearc/oil.nvim (`g?` dans oil pour l'aide)
--
-- Cohabite avec l'explorer de snacks (`<leader>e`) : oil ouvre les dossiers (`nvim .`, `:e dossier/`).

return {
  'stevearc/oil.nvim',
  lazy = false, -- chargé au démarrage pour prendre en charge `nvim .` et `:e dossier/`
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { '<leader>o', '<CMD>Oil<CR>', desc = 'Oil (dossier du fichier)' },
    { '<leader>O', '<CMD>Oil .<CR>', desc = 'Oil (dossier de travail)' },
  },
  config = function()
    require('oil').setup {
      default_file_explorer = true, -- `nvim .` et `:e dossier/` ouvrent oil
      keymaps = {
        ['<leader>-'] = 'actions.open_cwd',
        ['g.'] = { 'actions.toggle_hidden', mode = 'n' },
        -- Splits alignés sur snacks. Mappings propres au buffer oil : <C-v> (bloc visuel) reste intact
        -- dans les fichiers ; dans oil, <C-q> fait le bloc visuel.
        ['<C-v>'] = { 'actions.select', opts = { vertical = true }, mode = 'n' },
        ['<C-s>'] = { 'actions.select', opts = { horizontal = true }, mode = 'n' },
        ['<C-h>'] = false, -- rend <C-h> à la navigation entre fenêtres
      },
      -- Fichiers cachés visibles (`g.` pour basculer). Oil ne masque pas les fichiers ignorés par git.
      view_options = { show_hidden = true },
    }

    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Dossier du fichier courant (oil)' })
  end,
}
