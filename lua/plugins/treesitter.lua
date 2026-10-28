-- Treesitter : coloration syntaxique et indentation basées sur l'arbre syntaxique.
-- Doc : https://github.com/nvim-treesitter/nvim-treesitter (`:TSInstallInfo`, `:TSUpdate`)
-- Branche `master` (figée, toujours fonctionnelle). Passer à `main` est une migration à part.

return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  opts = {
    ensure_installed = {
      'bash',
      'c',
      'diff',
      'html',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'vim',
      'vimdoc',
      'typescript',
      'javascript',
      'tsx',
      'go',
      'gomod',
      'json',
      'yaml',
      'toml',
    },
    auto_install = true, -- installe le parser d'un langage à l'ouverture d'un fichier
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } },
  },
}
