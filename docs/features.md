# Fonctionnalités

Chaque section décrit ce que fait la fonctionnalité, où elle est configurée et sous quel préfixe la trouver.
Leader = `Espace`.

**Les raccourcis ne sont pas listés ici** : la référence est le `desc` de chaque mapping dans le code.
Pour les voir : `Espace` puis attendre (which-key, groupe par groupe), ou `<leader>sk` (recherche dans tous les keymaps).
Seules les touches internes aux plugins, que which-key n'affiche pas, sont rappelées ci-dessous.

| Préfixe | Groupe |
|---|---|
| `<leader>s` | Recherche (pickers, grug-far) |
| `<leader>g` | Git (lazygit, pickers git, diffview) |
| `<leader>h` | Hunks git (gitsigns) |
| `<leader>t` | Toggles (terminal, format on save, blame, inlay hints, rendu Markdown…) |
| `<leader><Tab>` | Onglets |
| `<leader>d` | Bases de données |
| `<leader>R` | Requêtes HTTP |
| `<leader>z` | Notes zk |
| `gr…` | LSP (définition, références, renommage, code actions…) |

## Sommaire

- [Trouver un fichier, chercher dans le projet](#trouver-un-fichier-chercher-dans-le-projet)
- [Rechercher / remplacer dans le projet](#rechercher--remplacer-dans-le-projet-grug-far)
- [La quickfix](#la-quickfix)
- [Arbre de fichiers](#arbre-de-fichiers-explorer)
- [LSP](#lsp)
- [Complétion](#complétion)
- [Formatage](#formatage)
- [Git](#git)
- [Terminal](#terminal)
- [Fenêtres nvim et panes tuios](#fenêtres-nvim-et-panes-tuios)
- [Ouvrir un fichier depuis un autre pane](#ouvrir-un-fichier-depuis-un-autre-pane-e)
- [Édition de texte](#édition-de-texte)
- [Requêtes HTTP](#requêtes-http-kulala)
- [Bases de données](#bases-de-données-dadbod)
- [Aperçu Markdown](#aperçu-markdown)
- [Notes zk](#notes-zk)
- [Interface](#interface)

---

## Trouver un fichier, chercher dans le projet

Picker de snacks.nvim (`lua/plugins/snacks.lua`), sous `<leader>s…`. Raccourcis directs : `<leader><leader>`
(fichiers récents puis projet), `<leader>/` (grep dans le projet), `<leader>,` (buffers).
Recherche floue : quelques lettres du chemin suffisent. Le grep accepte les regex ; pour filtrer par fichier,
syntaxe ripgrep après ` -- ` : `useState -- -g *.tsx`.

Dans un picker : `<C-j>`/`<C-k>` naviguer, `<C-s>` / `<C-h>` split vertical / horizontal, `<Tab>` sélection multiple,
`<C-q>` envoyer à la quickfix, `<A-h>` / `<A-i>` fichiers cachés / ignorés, `?` toutes les touches.

Pour **modifier** les résultats : remplacer partout → [grug-far](#rechercher--remplacer-dans-le-projet-grug-far) ;
un par un → `<C-q>` puis la [quickfix](#la-quickfix).

## Rechercher / remplacer dans le projet (grug-far)

`lua/plugins/search.lua`, sous `<leader>s…`. Buffer avec des champs **Search**, **Replace**, **Files Filter**, **Paths**
et **Flags** (options ripgrep) ; résultats en direct en dessous.

Dans grug-far : `<localleader>r` remplace partout, `<localleader>s` écrit dans les fichiers les lignes de résultat
**éditées à la main**, `<localleader>q` envoie à la quickfix, `g?` aide.

Usage type « multibuffer Zed » : chercher, éditer directement les lignes de résultat (motions vim, `:s`…),
puis `<localleader>s`. Vérifier ensuite avec `git diff` ou lazygit.

## La quickfix

Liste de positions (fichier, ligne, texte) intégrée à vim. On la remplit depuis un picker (`<C-q>`), depuis grug-far,
ou via `:make`, `:grep`. `:copen` / `:cclose`, `]q` / `[q` (natifs), `:cdo s/foo/bar/ | update` pour agir sur
chaque ligne puis enregistrer.

## Arbre de fichiers (explorer)

Explorer de snacks dans une barre à gauche (`<leader>e`), qui suit le fichier courant.
`nvim .`, `nvim dossier/` et `:e dossier/` ouvrent l'explorer sur ce dossier (oil est désactivé).

Dans l'explorer : `a` créer (finir par `/` pour un dossier), `r` renommer, `d` supprimer, `c` / `m` copier / déplacer,
`y` / `Y` copier le chemin absolu / relatif à la racine, `H` / `I` fichiers cachés / ignorés, `?` toutes les touches.

## LSP

`lua/plugins/lsp.lua` + `lsp/<serveur>.lua`, raccourcis sous `gr…` (posés quand un serveur s'attache).
Serveurs actifs : vtsls (TS/JS), eslint, lua_ls, gopls, jsonls, yamlls, bashls. Binaires installés par mason
(`:Mason`), sauf gopls (toolchain Go). Commandes Go supplémentaires (`:GoTest`, `:GoFillStruct`…) : go.nvim.

Ajouter un serveur : son nom dans `servers` (et `mason_tools` s'il vient de mason) ; réglages dans `lsp/<nom>.lua`.
Vérifier avec `:checkhealth vim.lsp`.

## Complétion

blink.cmp (`lua/plugins/completion.lua`) : LSP, chemins, snippets (friendly-snippets). Preset `enter` :
`<CR>` accepte, `<C-n>`/`<C-p>` naviguent, `<C-space>` ouvre le menu, `<C-e>` ferme,
`<Tab>`/`<S-Tab>` sautent entre les champs d'un snippet.

## Formatage

conform.nvim (`lua/plugins/format.lua`) formate à l'enregistrement, et à la demande. Le format on save se coupe
pour le buffer ou globalement (toggles sous `<leader>t…`, non persistants) ; C et C++ ne sont jamais formatés
à l'enregistrement. prettierd pour JS/TS/JSON/CSS/HTML/Markdown/YAML, stylua pour Lua, goimports pour Go ;
sinon le formateur du serveur LSP. `:ConformInfo` montre ce qui s'applique au buffer.

## Git

Trois outils (`lua/plugins/git.lua`, `lua/plugins/snacks.lua`) :

- **lazygit** (`<leader>gg`) pour committer, en plein écran par-dessus nvim ; `q` revient au même endroit ;
- **diffview** (`<leader>g…`) pour relire : diff complet côte à côte, historique d'un fichier ou du dépôt,
  diff de la branche contre main ;
- **gitsigns** (`<leader>h…`, `]h` / `[h`) pour agir hunk par hunk : stage, reset, aperçu, blame ;
  text object `ih`. Signes dans la gouttière : `+` ajouté, `~` modifié, `_` supprimé.

## Terminal

Terminal en split en bas de l'écran, 30 % de la hauteur, façon VS Code, fond plus sombre que l'éditeur
(`lua/plugins/snacks.lua`). Toggle : `<leader>tt`, ou `<C-_>` qui marche aussi depuis le terminal. C'est le
shell par défaut en mode interactif : alias et config du `~/.bashrc` disponibles. Le shell reste vivant quand on
le cache.

Dans le terminal : `<Esc><Esc>` passe en mode normal (un seul `<Esc>` est transmis au programme), puis `q` cache
le terminal et `gf` ouvre le fichier sous le curseur. Pour un shell durable ou plusieurs commandes en parallèle,
préférer un pane tuios.

## Fenêtres nvim et panes tuios

Deux couches séparées, sans plugin de liaison :

| | nvim (splits) | tuios (panes) |
|---|---|---|
| Changer de focus | `<C-h/j/k/l>` | `alt+flèches`, ou `ctrl+space` puis `h/j/k/l` |
| Couper | `<C-w>v` / `<C-w>s` | raccourcis tuios |
| Fermer | `<C-w>q` | raccourcis tuios |

Ouvrir un autre fichier directement en split : `<C-s>` / `<C-h>` dans un picker ou l'explorer.
Onglets nvim sous `<leader><Tab>…`, `gt` / `gT` pour passer de l'un à l'autre.

## Ouvrir un fichier depuis un autre pane (`e`)

Le premier nvim lancé dans une session tuios écoute sur un socket nommé d'après la session
(`lua/config/autocmds.lua`). Depuis n'importe quel autre pane de la même session :

```sh
e src/app.ts          # ouvre le fichier dans ce nvim et lui donne le focus
e                     # sans argument : lance un nvim normal
```

S'il n'y a pas de nvim dans la session, ou hors tuios, `e` lance simplement nvim.
Script : `bin/e` (à mettre dans le PATH, voir README).

## Édition de texte

`lua/plugins/editing.lua` :

- **Surround** (mini.surround) : `saiw)` entoure le mot de `()`, `sd'` supprime les `'` autour, `sr)'` remplace `()` par `''`.
- **Text objects** (mini.ai) : `va)`, `ci"`, `dif` (fonction), `yaa` (argument)… aussi à distance (`cin"` = prochaines guillemets).
- **Paires** (nvim-autopairs) : fermeture automatique des parenthèses et guillemets.
- **Bloc visuel** : `<C-v>` (si Windows Terminal ne l'intercepte pas) ou `<C-q>`.

## Requêtes HTTP (kulala)

`lua/plugins/lang/http.lua`. Dans un fichier `.http` / `.rest` : envoyer une requête, toutes, ou ouvrir un brouillon,
sous `<leader>R…`.

## Bases de données (dadbod)

vim-dadbod + vim-dadbod-ui (`lua/plugins/db.lua`), sous `<leader>d…`, chargés au premier raccourci ou à la première
commande `:DBUI*`. Dans un buffer SQL : exécuter le buffer ou la sélection, sauvegarder la requête.

Dans le panneau : `<CR>` / `o` déplie ou ouvre, `S` split vertical, `d` supprime, `r` renomme, `R` rafraîchit,
`q` ferme, `?` toutes les touches. Dans les résultats : `vic` copie la cellule, `yh` les en-têtes, `<C-]>` suit une
clé étrangère. Commandes plus rares : `:DBUIFindBuffer`, `:DBUIRenameBuffer`, `:DBUILastQueryInfo`.

URL au format dadbod, pas JDBC : `mysql://user:pass@127.0.0.1:4321/base`, `postgres://…`, `sqlite:chemin.db`.
Mettre `127.0.0.1` plutôt que `localhost` : avec `localhost`, le client `mysql` passe par le socket Unix et ignore
le port. Les adaptateurs appellent les clients en ligne de commande (`mysql`, `psql`, `sqlite3`…), qui doivent être installés.

Les connexions ajoutées sont enregistrées dans `~/.local/share/db_ui/connections.json` (hors dépôt, mots de passe
compris). Une URL invalide dans ce fichier fait échouer `:DBUI` entier (ex. `DB: no adapter for jdbc`) : la corriger
ou la supprimer directement dans le fichier.

## Aperçu Markdown

render-markdown.nvim (`lua/plugins/lang/markdown.lua`) met en forme les fichiers `.md` dans le buffer : titres,
tableaux, listes, cases à cocher, blocs de code. Sur la ligne du curseur, le texte brut réapparaît pour l'édition.
Rendu activable / désactivable sous `<leader>t…`. Les blocs Mermaid restent en source.

Diagrammes Mermaid (toggle sous `<leader>t…`, fichiers Markdown) : ouvre à côté un pane tuios qui les dessine
en caractères de boîte (`tuios mermaid --watch`) et les redessine à chaque `:w`. Le focus reste dans nvim ;
`q` dans le pane le ferme.

## Notes zk

zk-nvim (`lua/plugins/notes.lua`) branche le CLI `zk` sur nvim, sous `<leader>z…` :

- **Partout** : créer une note (le titre est demandé dans une saisie flottante), ouvrir une note, filtrer par tag,
  chercher dans le contenu. Hors d'un carnet, ces commandes visent `$ZK_NOTEBOOK_DIR` s'il est défini, sinon
  le dossier courant.
- **Dans une note d'un carnet** (dossier parent contenant `.zk/`) : backlinks, liens sortants, insérer un lien,
  créer une note dans le dossier courant ; en visuel, créer une note avec la sélection pour titre ou pour contenu
  (la sélection devient un lien), ou lier la sélection à une note existante.
- **LSP `zk`** attaché aux Markdown du carnet : complétion des liens en tapant `[[`, diagnostics de liens morts,
  `K` sur un lien pour l'aperçu de la note, `grd` pour la suivre.

Les pickers sont ceux de snacks. Réglages du carnet (format des liens, nom des fichiers, modèles) :
`<carnet>/.zk/config.toml`.

## Interface

- **Thème** : Ayu Dark (neovim-ayu, `lua/plugins/ui.lua`), comme dans Zed. `<leader>sC` liste les thèmes avec aperçu ;
  tokyonight reste installé.
- **Pane actif** : bordure orange fine (colorful-winsep, `:Winsep toggle`), fond légèrement plus sombre que les panes
  inactifs, ligne du curseur seulement dans ce pane. Dans l'explorer, la ligne du fichier ouvert dans le pane actif
  est surlignée en rouge (`lua/config/autocmds.lua`).
- **Ligne de commande** : `:`, `/` et `?` s'affichent dans une fenêtre au centre (noice.nvim, cmdline seulement).
- **Saisies et choix** : les invites (ex. renommage LSP) s'ouvrent dans une fenêtre flottante centrée, les listes de
  choix (code actions…) dans le picker (snacks `input` et `ui_select`).
