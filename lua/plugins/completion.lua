-- Complétion : blink.cmp (LSP, chemins, snippets) + LuaSnip.
-- Doc : https://cmp.saghen.dev
--
-- Preset 'enter' : <CR> accepte, <C-n>/<C-p> ou flèches naviguent, <C-space> ouvre le menu ou la doc,
-- <C-e> ferme, <Tab>/<S-Tab> sautent entre les champs d'un snippet, <C-k> affiche la signature.

return {
  'saghen/blink.cmp',
  event = 'VimEnter',
  version = '1.*',
  dependencies = {
    { -- Moteur de snippets. https://github.com/L3MON4D3/LuaSnip
      'L3MON4D3/LuaSnip',
      version = '2.*',
      build = (function()
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      dependencies = {
        { -- Snippets prêts à l'emploi au format VS Code, par langage
          'rafamadriz/friendly-snippets',
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
          end,
        },
      },
      opts = {},
    },
    'folke/lazydev.nvim',
  },
  --- @module 'blink.cmp'
  --- @type blink.cmp.Config
  opts = {
    keymap = { preset = 'enter' },
    appearance = { nerd_font_variant = 'mono' },
    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 300 },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'lazydev' },
      providers = {
        lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
      },
    },
    snippets = { preset = 'luasnip' },
    fuzzy = { implementation = 'prefer_rust_with_warning' },
    signature = { enabled = true },
  },
}
