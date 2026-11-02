-- Formatage : conform.nvim, à l'enregistrement et avec <leader>f.
-- Format on save on/off : <leader>tf (buffer courant), <leader>tF (global).
-- Doc : https://github.com/stevearc/conform.nvim (`:ConformInfo` montre les formateurs du buffer)
-- Sans formateur listé pour un filetype, conform utilise le formatage du serveur LSP.

return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = 'Formater le buffer',
    },
  },
  init = function()
    -- Toggles du format on save (non persistants : réactivé à chaque démarrage).
    -- Déclarés à VeryLazy pour que snacks soit déjà chargé.
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      once = true,
      callback = function()
        Snacks.toggle
          .new({
            name = 'Format on save (buffer)',
            get = function()
              return not vim.b.disable_autoformat
            end,
            set = function(state)
              vim.b.disable_autoformat = not state
            end,
          })
          :map '<leader>tf'
        Snacks.toggle
          .new({
            name = 'Format on save (global)',
            get = function()
              return not vim.g.disable_autoformat
            end,
            set = function(state)
              vim.g.disable_autoformat = not state
            end,
          })
          :map '<leader>tF'
      end,
    })
  end,
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Coupé via <leader>tf (buffer) ou <leader>tF (global)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return nil
      end
      -- Filetypes jamais formatés à l'enregistrement
      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      end
      return { timeout_ms = 500, lsp_format = 'fallback' }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      go = { 'goimports' }, -- gofmt + tri des imports (binaire dans ~/go/bin)
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
      typescript = { 'prettierd', 'prettier', stop_after_first = true },
      javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      json = { 'prettierd', 'prettier', stop_after_first = true },
      css = { 'prettierd', 'prettier', stop_after_first = true },
      html = { 'prettierd', 'prettier', stop_after_first = true },
      markdown = { 'prettierd', 'prettier', stop_after_first = true },
      yaml = { 'prettierd', 'prettier', stop_after_first = true },
    },
  },
}
