-- go.nvim : commandes Go (:GoTest, :GoFillStruct, :GoIfErr, :GoAddTag…).
-- Doc : https://github.com/ray-x/go.nvim
-- gopls est démarré par lsp.lua et le formatage passe par conform (goimports) : go.nvim ne fait ni l'un ni l'autre.

return {
  'ray-x/go.nvim',
  dependencies = {
    'ray-x/guihua.lua',
    'neovim/nvim-lspconfig',
    'nvim-treesitter/nvim-treesitter',
  },
  ft = { 'go', 'gomod' },
  event = { 'CmdlineEnter' },
  opts = {
    diagnostic = false, -- garde la config des diagnostics de lsp.lua (go.nvim l'écraserait sinon)
    lsp_codelens = false, -- appelle vim.lsp.codelens.enable, qui n'existe qu'à partir de nvim 0.12
  },
  build = ':lua require("go.install").update_all_sync()', -- installe / met à jour les binaires Go
}
