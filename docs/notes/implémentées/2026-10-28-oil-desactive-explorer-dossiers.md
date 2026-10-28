# Oil désactivé, l'explorer ouvre les dossiers

**Décision** : oil.nvim désactivé (`enabled = false` dans `lua/plugins/oil.lua`, package conservé).
`nvim .` et `:e dossier/` ouvrent l'explorer de snacks (`replace_netrw = true`). Le raccourci `-` disparaît.

**Pourquoi** : oil gênait à l'usage ; avec un explorer en barre latérale, la pratique courante est que
l'explorer prenne en charge l'ouverture des dossiers (comme neo-tree `hijack_netrw` ou nvim-tree `hijack_directories`).

**Remplace** la partie « Oil reste… » de `2026-10-28-picker-explorer-snacks.md`.
**À suivre** : supprimer la spec et `:Lazy clean` si oil ne manque pas.
