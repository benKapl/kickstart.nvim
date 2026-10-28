-- snacks.nvim : picker (fichiers, grep, LSP…), explorer (arbre de fichiers) et lazygit.
-- Doc : https://github.com/folke/snacks.nvim (`:help snacks-picker`, `:help snacks-explorer`)
--
-- Dans un picker : <C-j>/<C-k> naviguer, <Tab> sélectionner plusieurs, <C-q> envoyer à la quickfix,
-- <A-h> fichiers cachés, <A-i> fichiers ignorés, <Esc> fermer. Liste complète : `?` dans le picker.

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    picker = { ui_select = true }, -- remplace aussi vim.ui.select (code actions, etc.)
    explorer = { replace_netrw = false }, -- oil reste l'explorateur des dossiers (`nvim .`, `-`)
    lazygit = {},
  },
  keys = {
    -- Principaux
    {
      '<leader><leader>',
      function()
        Snacks.picker.smart()
      end,
      desc = 'Fichiers (récents + projet)',
    },
    {
      '<leader>/',
      function()
        Snacks.picker.grep()
      end,
      desc = 'Grep dans le projet',
    },
    {
      '<leader>,',
      function()
        Snacks.picker.buffers()
      end,
      desc = 'Buffers ouverts',
    },
    {
      '<leader>e',
      function()
        Snacks.explorer()
      end,
      desc = 'Explorer (arbre de fichiers)',
    },

    -- Recherche
    {
      '<leader>sf',
      function()
        Snacks.picker.files()
      end,
      desc = 'Fichiers',
    },
    {
      '<leader>sw',
      function()
        Snacks.picker.grep_word()
      end,
      desc = 'Mot ou sélection dans le projet',
      mode = { 'n', 'x' },
    },
    {
      '<leader>sb',
      function()
        Snacks.picker.lines()
      end,
      desc = 'Lignes du buffer',
    },
    {
      '<leader>sB',
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = 'Grep dans les buffers ouverts',
    },
    {
      '<leader>s.',
      function()
        Snacks.picker.recent()
      end,
      desc = 'Fichiers récents',
    },
    {
      '<leader>sr',
      function()
        Snacks.picker.resume()
      end,
      desc = 'Reprendre la dernière recherche',
    },
    {
      '<leader>sd',
      function()
        Snacks.picker.diagnostics()
      end,
      desc = 'Diagnostics',
    },
    {
      '<leader>sh',
      function()
        Snacks.picker.help()
      end,
      desc = 'Aide',
    },
    {
      '<leader>sk',
      function()
        Snacks.picker.keymaps()
      end,
      desc = 'Keymaps',
    },
    {
      '<leader>sq',
      function()
        Snacks.picker.qflist()
      end,
      desc = 'Quickfix',
    },
    {
      '<leader>ss',
      function()
        Snacks.picker()
      end,
      desc = 'Tous les pickers',
    },
    {
      '<leader>sC',
      function()
        Snacks.picker.colorschemes()
      end,
      desc = 'Thèmes',
    },
    {
      '<leader>sn',
      function()
        Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
      end,
      desc = 'Fichiers de la config nvim',
    },

    -- Git
    {
      '<leader>gg',
      function()
        Snacks.lazygit()
      end,
      desc = 'Lazygit',
    },
    {
      '<leader>gs',
      function()
        Snacks.picker.git_status()
      end,
      desc = 'Fichiers modifiés',
    },
    {
      '<leader>gl',
      function()
        Snacks.picker.git_log_file()
      end,
      desc = 'Historique du fichier',
    },
  },
}
