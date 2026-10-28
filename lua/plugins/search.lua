-- grug-far : rechercher / remplacer dans tout le projet (ripgrep), avec résultats éditables.
-- Doc : https://github.com/MagicDuck/grug-far.nvim (`:help grug-far`)
--
-- Dans le buffer grug-far : remplir Search / Replace (et Files Filter, Flags), puis
--   <localleader>r  remplacer partout          <localleader>s  synchroniser les lignes éditées à la main
--   <localleader>q  envoyer à la quickfix      <localleader>c  fermer
-- Les raccourcis sont rappelés en haut du buffer ; `g?` affiche l'aide.

return {
  'MagicDuck/grug-far.nvim',
  cmd = { 'GrugFar', 'GrugFarWithin' },
  opts = {},
  keys = {
    {
      '<leader>sR',
      function()
        require('grug-far').open()
      end,
      desc = 'Rechercher / remplacer (projet)',
    },
    {
      '<leader>sR',
      function()
        require('grug-far').with_visual_selection()
      end,
      mode = 'x',
      desc = 'Rechercher / remplacer la sélection',
    },
    {
      '<leader>sF',
      function()
        require('grug-far').open { prefills = { paths = vim.fn.expand '%' } }
      end,
      desc = 'Rechercher / remplacer (fichier courant)',
    },
  },
}
