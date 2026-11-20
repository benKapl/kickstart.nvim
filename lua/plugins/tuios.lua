-- tuios-nvim-navigator : navigation unifiée entre les splits Neovim et les panes TUIOS.
-- Ctrl+h/j/k/l déplace entre splits ; au bord, le focus passe au pane TUIOS adjacent.
-- Doc : https://github.com/Tim4c/tuios-nvim-navigator
-- Requiert une version de TUIOS avec le support de navigation Neovim (PR tuios#318).
-- Côté TUIOS, la navigation entre panes doit utiliser les mêmes touches pour que l'aller-retour soit fluide.

return {
  'Tim4c/tuios-nvim-navigator',
  lazy = false, -- les keymaps doivent exister dès le démarrage
  config = function()
    require('tuios-nvim-navigator').setup {
      keymaps = {
        left = '<C-h>',
        down = '<C-j>',
        up = '<C-k>',
        right = '<C-l>',
      },
    }
  end,
}
