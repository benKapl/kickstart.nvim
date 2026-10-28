# Fonctionnalités

Chaque section décrit ce que fait la fonctionnalité, comment s'en servir et où elle est configurée.
Leader = `Espace`. Aide-mémoire en direct : appuyer sur `Espace` et attendre (which-key), ou `<leader>sk`.

## Sommaire

- [Trouver un fichier](#trouver-un-fichier)
- [Chercher dans le projet](#chercher-dans-le-projet-léquivalent-de-ctrlshiftf)
- [Rechercher / remplacer dans le projet](#rechercher--remplacer-dans-le-projet-grug-far)
- [La quickfix](#la-quickfix)
- [Arbre de fichiers](#arbre-de-fichiers-explorer)
- [LSP](#lsp-navigation-diagnostics-renommage)
- [Complétion](#complétion)
- [Formatage](#formatage)
- [Git](#git)
- [Fenêtres nvim et panes tuios](#fenêtres-nvim-et-panes-tuios)
- [Ouvrir un fichier depuis un autre pane](#ouvrir-un-fichier-depuis-un-autre-pane-e)
- [Édition de texte](#édition-de-texte)
- [Requêtes HTTP](#requêtes-http-kulala)

---

## Trouver un fichier

Picker de snacks.nvim (`lua/plugins/snacks.lua`). Recherche floue : taper quelques lettres du chemin suffit.

| Touche | Action |
|---|---|
| `<leader><leader>` | Fichiers : récents et ouverts d'abord, puis le reste du projet |
| `<leader>sf` | Fichiers du projet uniquement |
| `<leader>s.` | Fichiers récents |
| `<leader>,` | Buffers ouverts |
| `<leader>sn` | Fichiers de la config nvim |

Dans le picker : `<C-j>`/`<C-k>` naviguer, `<CR>` ouvrir, `<C-v>` / `<C-s>` ouvrir en split vertical / horizontal,
`<Tab>` sélectionner plusieurs éléments, `<A-h>` fichiers cachés, `<A-i>` fichiers ignorés par git, `?` toutes les touches.

## Chercher dans le projet (l'équivalent de Ctrl+Shift+F)

| Touche | Action |
|---|---|
| `<leader>/` | Grep en direct dans tout le projet (ripgrep) |
| `<leader>sw` | Cherche le mot sous le curseur, ou la sélection en mode visuel |
| `<leader>sb` | Lignes du buffer courant |
| `<leader>sB` | Grep dans les buffers ouverts |
| `<leader>sr` | Rouvre la dernière recherche, telle quelle |

Le grep accepte les regex. Pour filtrer par fichier, utiliser la syntaxe ripgrep après ` -- ` :
`useState -- -g *.tsx`.

Pour **modifier** les résultats, deux chemins :

- remplacer un texte partout → [grug-far](#rechercher--remplacer-dans-le-projet-grug-far) ;
- traiter les résultats un par un → `<C-q>` les envoie dans la [quickfix](#la-quickfix).

## Rechercher / remplacer dans le projet (grug-far)

`lua/plugins/search.lua`. Ouvre un buffer avec des champs **Search**, **Replace**, **Files Filter**, **Paths**
et **Flags** (options ripgrep) ; les résultats s'affichent en direct en dessous.

| Touche | Action |
|---|---|
| `<leader>sR` | Ouvrir (en visuel : préremplit avec la sélection) |
| `<leader>sF` | Ouvrir, limité au fichier courant |
| `<localleader>r` (dans grug-far) | Appliquer le remplacement partout |
| `<localleader>s` | Synchroniser : les lignes de résultat **éditées à la main** sont écrites dans les fichiers |
| `<localleader>q` | Envoyer les résultats dans la quickfix |
| `<CR>` sur un résultat | Ouvrir le fichier à cette ligne |
| `g?` | Aide |

Usage type « multibuffer Zed » : chercher, éditer directement les lignes de résultat (avec les motions vim,
`:s`, etc.), puis `<localleader>s`. Vérifier ensuite avec `git diff` ou `<leader>gg`.

## La quickfix

Liste de positions (fichier, ligne, texte) intégrée à vim, affichée dans une fenêtre en bas.
On la remplit depuis un picker (`<C-q>`), depuis grug-far, ou via `:make`, `:grep`.

| Commande | Action |
|---|---|
| `:copen` / `:cclose` | Afficher / fermer la fenêtre |
| `]q` / `[q` | Élément suivant / précédent (mappings natifs de nvim 0.11) |
| `<leader>sq` | Parcourir la quickfix dans le picker |
| `:cdo s/foo/bar/ \| update` | Exécuter une commande sur chaque ligne de la liste, puis enregistrer |

## Arbre de fichiers (explorer)

`<leader>e` ouvre ou ferme l'explorer de snacks dans une barre à gauche. Il suit le fichier courant.
`nvim .` (ou `nvim dossier/`, `:e dossier/`) ouvre l'explorer sur ce dossier.

| Touche (dans l'explorer) | Action |
|---|---|
| `<CR>` / `l` | Ouvrir le fichier, déplier le dossier |
| `h` | Replier |
| `<C-v>` / `<C-s>` | Ouvrir dans un split vertical / horizontal |
| `a` | Créer (finir par `/` pour un dossier) |
| `r` | Renommer |
| `d` | Supprimer |
| `c` / `m` | Copier / déplacer |
| `H` / `I` | Fichiers cachés / ignorés |
| `/` | Filtrer |
| `?` | Toutes les touches |

## LSP (navigation, diagnostics, renommage)

`lua/plugins/lsp.lua` + `lsp/<serveur>.lua`. Serveurs actifs : vtsls (TS/JS), eslint, lua_ls, gopls, jsonls,
yamlls, bashls. Installation des binaires par mason (`:Mason`), sauf gopls (toolchain Go).

| Touche | Action |
|---|---|
| `grd` | Aller à la définition |
| `grr` | Références (picker) |
| `gri` | Implémentations |
| `grt` | Définition du type |
| `grD` | Déclaration |
| `grn` | Renommer le symbole dans tout le projet |
| `gra` | Code actions (imports, corrections…) |
| `K` | Documentation du symbole |
| `gO` / `gW` | Symboles du fichier / du projet |
| `<C-s>` (insertion) | Signature de la fonction |
| `]d` / `[d` | Diagnostic suivant / précédent |
| `<C-w>d` | Détail du diagnostic sous le curseur |
| `<leader>sd` | Tous les diagnostics (picker) |
| `<leader>q` | Diagnostics du buffer dans la location list |
| `<leader>th` | Afficher / masquer les inlay hints |

Ajouter un serveur : son nom dans `servers` (et `mason_tools` s'il vient de mason) dans `lua/plugins/lsp.lua` ;
réglages spécifiques dans `lsp/<nom>.lua`. Vérifier avec `:checkhealth vim.lsp`.

## Complétion

blink.cmp (`lua/plugins/completion.lua`) : suggestions LSP, chemins, snippets (friendly-snippets).
`<CR>` accepte, `<C-n>`/`<C-p>` naviguent, `<C-space>` ouvre le menu, `<C-e>` ferme,
`<Tab>`/`<S-Tab>` sautent entre les champs d'un snippet.

## Formatage

conform.nvim (`lua/plugins/format.lua`) formate à l'enregistrement. `<leader>f` formate à la demande.
prettierd pour JS/TS/JSON/CSS/HTML, stylua pour Lua, goimports pour Go ; sinon le formateur du serveur LSP.
`:ConformInfo` montre ce qui s'applique au buffer.

## Git

| Touche | Action |
|---|---|
| `<leader>gg` | Lazygit en plein écran par-dessus nvim ; `q` le ferme et revient au même endroit |
| `<leader>gs` | Fichiers modifiés (picker, avec aperçu du diff) |
| `<leader>gl` | Historique du fichier courant |

Signes dans la gouttière (gitsigns) : `+` ajouté, `~` modifié, `_` supprimé.

## Fenêtres nvim et panes tuios

Deux couches séparées, sans plugin de liaison :

| | nvim (splits) | tuios (panes) |
|---|---|---|
| Changer de focus | `<C-h/j/k/l>` | `alt+flèches`, ou `ctrl+space` puis `h/j/k/l` |
| Couper | `:vsplit` / `:split` (`<C-w>v` / `<C-w>s`) | raccourcis tuios |
| Fermer | `<C-w>q` | raccourcis tuios |

Nouveau split :
- même fichier : `<C-w>v` / `<C-w>s` (`:vs` / `:sp`) ;
- vide, pour y ouvrir ensuite un fichier avec `<leader><leader>` : `:vnew` / `<C-w>n` (`:new`) ;
- directement sur un autre fichier : `<C-v>` / `<C-s>` dans un picker ou l'explorer.

Autres commandes de fenêtres utiles : `<C-w>o` garder seulement la fenêtre courante, `<C-w>=` égaliser les tailles,
`<C-w>H/J/K/L` déplacer la fenêtre vers un bord, `:help window-moving`.

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

- **Surround** (mini.surround) : `saiw)` entoure le mot de `()`, `sd'` supprime les `'` autour, `sr)'` remplace `()` par `''`.
- **Text objects** (mini.ai) : `va)`, `ci"`, `dif` (fonction), `yaa` (argument)… fonctionnent aussi à distance (`cin"` = prochaines guillemets).
- **Paires** (nvim-autopairs) : fermeture automatique des parenthèses et guillemets.
- **Bloc visuel** : `<C-v>` (si Windows Terminal ne l'intercepte pas) ou `<C-q>`.

## Requêtes HTTP (kulala)

Dans un fichier `.http` : `<leader>Rs` envoie la requête sous le curseur, `<leader>Ra` toutes, `<leader>Rb` ouvre un brouillon.
