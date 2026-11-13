-- snacks.nvim : picker (fichiers, grep, LSP…), explorer (arbre de fichiers), lazygit et terminal.
-- Doc : https://github.com/folke/snacks.nvim (`:help snacks-picker`, `:help snacks-explorer`)
--
-- Dans un picker : <C-j>/<C-k> naviguer, <Tab> sélectionner plusieurs, <C-q> envoyer à la quickfix,
-- <C-s> split vertical, <C-h> split horizontal, <A-h> fichiers cachés, <A-i> fichiers ignorés, <Esc> fermer.
-- Liste complète : `?` dans le picker.

-- Touches de split, dans le champ de saisie (insert + normal) et dans la liste
local split_keys = {
  ['<c-s>'] = { 'edit_vsplit', mode = { 'i', 'n' } },
  ['<c-h>'] = { 'edit_split', mode = { 'i', 'n' } },
}

-- Terminal en split horizontal en bas (façon VS Code). Shell par défaut (bash interactif : alias du ~/.bashrc).
-- Fond plus sombre que l'éditeur (#0B0E14), actif ou non, pour le distinguer du code.
local function toggle_terminal()
  vim.api.nvim_set_hl(0, 'SnacksTerminalNormal', { bg = '#05070A' }) -- redéfini à chaque appel : survit à un `:colorscheme`
  Snacks.terminal.toggle(nil, {
    win = {
      position = 'bottom',
      height = 0.3, -- 30 % de la hauteur
      wo = { winhighlight = 'Normal:SnacksTerminalNormal,NormalNC:SnacksTerminalNormal' },
    },
  })
end

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    input = { enabled = true }, -- remplace vim.ui.input (ex. `grn`) par une fenêtre flottante
    styles = {
      input = { row = false }, -- false = centré verticalement (défaut : 2 lignes sous le haut)
    },
    picker = {
      ui_select = true, -- remplace aussi vim.ui.select (code actions, etc.)
      win = {
        input = { keys = split_keys },
        list = { keys = split_keys },
      },
      sources = {
        explorer = {
          actions = {
            -- `y` copie le chemin absolu (défaut snacks) ; `Y` copie le chemin relatif à la racine
            -- de l'explorer (le dossier affiché en haut)
            yank_relative = function(picker)
              local root = picker:cwd()
              local paths = vim.tbl_map(function(item)
                local path = Snacks.picker.util.path(item)
                return vim.fs.relpath(root, path) or path
              end, picker:selected { fallback = true })
              picker.list:set_selected() -- vide la sélection
              vim.fn.setreg('+', table.concat(paths, '\n'))
              vim.notify('Copié : ' .. table.concat(paths, ', '))
            end,
          },
          win = { list = { keys = { ['Y'] = 'yank_relative' } } },
        },
      },
    },
    explorer = { replace_netrw = true }, -- `nvim .` et `:e dossier/` ouvrent l'explorer
    lazygit = {},
    terminal = {},
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
    {
      '<leader>tt',
      toggle_terminal,
      desc = 'Terminal',
    },
    -- Toggle direct, y compris depuis le mode terminal.
    { '<C-_>', toggle_terminal, mode = { 'n', 't' }, desc = 'Terminal' },

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
