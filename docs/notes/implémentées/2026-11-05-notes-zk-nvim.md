# Notes : zk-nvim

**Décision** : zk-nvim (`lua/plugins/notes.lua`) pour piloter le CLI `zk` déjà installé localement, avec
`picker = 'snacks_picker'` (snacks est le picker du reste de la config). Le LSP `zk lsp` est démarré par le
plugin (`auto_attach` sur `markdown`), pas par `vim.lsp.enable` : les capacités de blink.cmp lui sont passées à la main.

**Chargement** : `ft = 'markdown'`, plus les commandes et keymaps globales (`<leader>zn/zo/zT/zf`) pour ouvrir
le carnet depuis un autre type de buffer.

**Keymaps de carnet** : posées par un autocmd `FileType markdown` uniquement si `zk.util.notebook_root` trouve
un `.zk/` au-dessus du fichier, pour ne pas polluer les Markdown hors carnet (README, docs de projet).
Le titre des nouvelles notes passe par `vim.ui.input` (saisie flottante snacks) plutôt que `vim.fn.input`.

**Groupe which-key** : `<leader>z` (Notes zk), en normal et visuel.
