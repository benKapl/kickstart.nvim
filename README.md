# Config Neovim

Config personnelle, issue de [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) et découpée en modules.
But : retrouver dans le terminal (sous tuios) ce que Zed apporte (picker, recherche dans le projet, arbre de fichiers, LSP).

- **Ce que fait la config et comment s'en servir** : [docs/features.md](docs/features.md)
- **Historique des décisions** : [docs/notes/](docs/notes/)

## Prérequis

nvim ≥ 0.11, `git`, `make`, un compilateur C, `rg` (ripgrep), `fd`, `lazygit`, une Nerd Font.
Go : la toolchain fournit `gopls` et `goimports` (`~/go/bin` dans le PATH).

## Installation

```sh
git clone git@github.com:benKapl/kickstart.nvim.git ~/.config/nvim
nvim   # lazy.nvim installe les plugins, mason installe les serveurs LSP
```

Commande `e` (ouvrir un fichier dans le nvim de la session tuios) : ajouter à `~/.bashrc`

```sh
export PATH="$HOME/.config/nvim/bin:$PATH"
```

## Organisation

```
init.lua                 point d'entrée : charge lua/config/*
lua/config/
  options.lua            options vim, leader, presse-papiers
  keymaps.lua            keymaps globales
  autocmds.lua           autocommandes, socket serveur par session tuios
  lazy.lua               bootstrap de lazy.nvim
lua/plugins/             un fichier par domaine (chaque fichier commence par son rôle et le lien de sa doc)
  ui.lua                 thème, which-key, todo-comments
  snacks.lua             picker, explorer, lazygit
  search.lua             grug-far (rechercher / remplacer)
  editing.lua            mini (ai, surround, statusline), autopairs, guess-indent
  lsp.lua                serveurs LSP, mason, diagnostics, keymaps LSP
  completion.lua         blink.cmp, LuaSnip
  format.lua             conform
  treesitter.lua
  git.lua                gitsigns
  oil.lua                désactivé (enabled = false), remplacé par l'explorer
  lang/                  plugins propres à un langage (go, http)
lsp/                     réglages par serveur LSP, fusionnés avec ceux de nvim-lspconfig
bin/e                    ouvre des fichiers dans le nvim de la session tuios
docs/                    documentation et notes de décision
```

## Maintenance

| Tâche | Comment |
|---|---|
| Ajouter un plugin | Une spec dans le fichier du domaine concerné (ou un nouveau fichier dans `lua/plugins/`) |
| Ajouter un serveur LSP | `servers` (+ `mason_tools`) dans `lua/plugins/lsp.lua`, réglages dans `lsp/<nom>.lua` |
| Mettre à jour les plugins | `:Lazy update`, tester, puis commiter `lazy-lock.json` |
| Diagnostiquer | `:checkhealth`, `:checkhealth vim.lsp`, `:Lazy`, `:Mason`, `:ConformInfo` |
| Une décision change | Nouveau fichier dans `docs/notes/` (voir la règle ci-dessous) |

### Notes de décision

`docs/notes/` contient un fichier par décision ou fonctionnalité, nommé `AAAA-MM-JJ-<sujet>.md`, rangé selon son état :

- `prévues/` : décidé, pas encore fait ;
- `implémentées/` : en place ;
- `archivées/` : abandonné ou remplacé.

Un fichier n'est **jamais modifié** : il est déplacé d'un dossier à l'autre ou supprimé.
Si une décision change, on écrit un nouveau fichier daté.
