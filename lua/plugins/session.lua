-- persistence.nvim : sauvegarde automatique de la session (buffers, fenêtres, onglets) à la sortie,
-- une session par dossier de travail. Quitter normalement (`:qa`), puis relancer `nvim` dans le même
-- dossier et restaurer avec `<leader>.s`.
-- Doc : https://github.com/folke/persistence.nvim

return {
  'folke/persistence.nvim',
  event = 'BufReadPre', -- démarre la sauvegarde dès qu'un fichier est ouvert
  opts = {},
  keys = {
    {
      '<leader>.s',
      function()
        require('persistence').load()
      end,
      desc = 'Restaurer la session (dossier courant)',
    },
    {
      '<leader>.l',
      function()
        require('persistence').load { last = true }
      end,
      desc = 'Restaurer la dernière session',
    },
    {
      '<leader>.S',
      function()
        require('persistence').select()
      end,
      desc = 'Choisir une session',
    },
    {
      '<leader>.d',
      function()
        require('persistence').stop()
      end,
      desc = 'Ne pas sauvegarder cette session',
    },
  },
}
