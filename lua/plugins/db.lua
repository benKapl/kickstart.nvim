-- vim-dadbod-ui : explorer et requêter des bases de données (MySQL, PostgreSQL, SQLite…) depuis nvim.
-- Doc : https://github.com/kristijanhusak/vim-dadbod-ui (`:help dadbod-ui`)
--
-- Raccourcis sous <leader>d. Dans les buffers SQL, ils remplacent ceux du plugin (<leader>S, <leader>W, <leader>E) ;
-- le reste passe par les commandes :DBUI…. Les raccourcis par défaut des résultats (vic, yh, <C-]>) sont conservés.
-- Connexions enregistrées dans ~/.local/share/db_ui/connections.json (URL dadbod, pas JDBC).

return {
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod', lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    cmd = { 'DBUI', 'DBUIToggle', 'DBUIClose', 'DBUIAddConnection', 'DBUIFindBuffer', 'DBUIRenameBuffer', 'DBUILastQueryInfo' },
    keys = {
      { '<leader>du', '<cmd>DBUIToggle<cr>', desc = 'Panneau DBUI' },
      { '<leader>da', '<cmd>DBUIAddConnection<cr>', desc = 'Ajouter une connexion' },
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_disable_mappings_sql = 1

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('config-dadbod-keymaps', { clear = true }),
        pattern = { 'sql', 'mysql', 'plsql' },
        callback = function(event)
          local function map(lhs, rhs, desc, mode)
            vim.keymap.set(mode or 'n', lhs, rhs, { buffer = event.buf, remap = true, desc = desc })
          end
          map('<leader>de', '<Plug>(DBUI_ExecuteQuery)', 'Exécuter la requête', { 'n', 'x' })
          map('<leader>ds', '<Plug>(DBUI_SaveQuery)', 'Sauvegarder la requête')
        end,
      })
    end,
  },
}
