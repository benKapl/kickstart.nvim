-- oil.nvim : un dossier s'édite comme un buffer texte. Renommer = éditer la ligne, déplacer =
-- couper/coller la ligne dans un autre dossier, supprimer = dd. `:w` applique les changements.
-- Doc : https://github.com/stevearc/oil.nvim (`g?` dans oil pour l'aide)

-- Désactivé (2026-10-28) : l'explorer de snacks ouvre les dossiers. Remettre `enabled = true` pour le retrouver.

return {
  'stevearc/oil.nvim',
  enabled = false,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
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
      view_options = { show_hidden = true },
    }

    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Dossier du fichier courant (oil)' })
  end,
}
