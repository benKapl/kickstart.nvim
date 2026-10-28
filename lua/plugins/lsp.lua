-- LSP avec l'API native de nvim 0.11 (`:help lsp-config`).
--   - nvim-lspconfig fournit la config par défaut de chaque serveur (cmd, filetypes, root_markers).
--   - lsp/<serveur>.lua (racine de la config) ajoute nos réglages ; nvim les fusionne avec les défauts.
--   - mason installe les binaires (`:Mason`) ; la liste `servers` ci-dessous décide de ce qui démarre.
-- Ajouter un serveur : son nom lspconfig dans `servers` (+ lsp/<nom>.lua si besoin de réglages).
-- Diagnostic : `:checkhealth vim.lsp` montre les clients attachés au buffer courant.

-- Serveurs démarrés automatiquement (noms nvim-lspconfig)
local servers = {
  'vtsls', -- TypeScript / JavaScript (même moteur que VS Code et Zed)
  'eslint',
  'lua_ls',
  'gopls', -- binaire fourni par la toolchain Go (~/go/bin), pas par mason
  'jsonls',
  'yamlls',
  'bashls',
}

-- Outils installés par mason. ts_ls reste installé, mais n'est plus démarré (remplacé par vtsls).
local mason_tools = {
  'vtsls',
  'ts_ls',
  'eslint',
  'lua_ls',
  'jsonls',
  'yamlls',
  'bashls',
  'stylua',
  'prettierd',
}

-- Keymaps posées sur chaque buffer où un serveur s'attache.
-- nvim 0.11 fournit déjà grn (renommer), gra (code action), K (doc), <C-s> en insert (signature).
local function on_attach(event)
  local map = function(keys, func, desc, mode)
    vim.keymap.set(mode or 'n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
  end

  map('grn', vim.lsp.buf.rename, 'Renommer le symbole')
  map('gra', vim.lsp.buf.code_action, 'Code action', { 'n', 'x' })
  map('grd', function()
    Snacks.picker.lsp_definitions()
  end, 'Définition')
  map('grD', vim.lsp.buf.declaration, 'Déclaration')
  map('grr', function()
    Snacks.picker.lsp_references()
  end, 'Références')
  map('gri', function()
    Snacks.picker.lsp_implementations()
  end, 'Implémentations')
  map('grt', function()
    Snacks.picker.lsp_type_definitions()
  end, 'Définition du type')
  map('gO', function()
    Snacks.picker.lsp_symbols()
  end, 'Symboles du fichier')
  map('gW', function()
    Snacks.picker.lsp_workspace_symbols()
  end, 'Symboles du projet')

  local client = vim.lsp.get_client_by_id(event.data.client_id)
  if not client then
    return
  end

  -- Surligne les autres occurrences du symbole sous le curseur après un court arrêt
  if client:supports_method('textDocument/documentHighlight', event.buf) then
    local group = vim.api.nvim_create_augroup('config-lsp-highlight', { clear = false })
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      buffer = event.buf,
      group = group,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      buffer = event.buf,
      group = group,
      callback = vim.lsp.buf.clear_references,
    })
    vim.api.nvim_create_autocmd('LspDetach', {
      group = vim.api.nvim_create_augroup('config-lsp-detach', { clear = true }),
      callback = function(event2)
        vim.lsp.buf.clear_references()
        vim.api.nvim_clear_autocmds { group = 'config-lsp-highlight', buffer = event2.buf }
      end,
    })
  end

  if client:supports_method('textDocument/inlayHint', event.buf) then
    map('<leader>th', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
    end, 'Afficher / masquer les inlay hints')
  end
end

return {
  { -- Types et complétion de l'API nvim dans les fichiers Lua de la config
    -- https://github.com/folke/lazydev.nvim
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        { path = 'snacks.nvim', words = { 'Snacks' } },
      },
    },
  },

  {
    -- https://github.com/neovim/nvim-lspconfig
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} }, -- https://github.com/mason-org/mason.nvim
      'mason-org/mason-lspconfig.nvim', -- traduit les noms lspconfig en paquets mason
      'WhoIsSethDaniel/mason-tool-installer.nvim', -- installe mason_tools au démarrage
      { 'j-hui/fidget.nvim', opts = {} }, -- progression LSP en bas à droite
      'saghen/blink.cmp',
      'b0o/SchemaStore.nvim', -- schémas JSON/YAML (package.json, tsconfig, docker-compose…)
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('config-lsp-attach', { clear = true }),
        callback = on_attach,
      })

      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        },
        virtual_text = { source = 'if_many', spacing = 2 },
      }

      -- Capacités de complétion de blink.cmp pour tous les serveurs
      vim.lsp.config('*', { capabilities = require('blink.cmp').get_lsp_capabilities() })

      require('mason-lspconfig').setup { automatic_enable = false } -- on active explicitement ci-dessous
      require('mason-tool-installer').setup { ensure_installed = mason_tools }

      vim.lsp.enable(servers)
    end,
  },
}
