# Supprimer les plugins legacy

**Quand** : après validation à l'usage de snacks (picker) et des mappings `<C-hjkl>` natifs.
**Quoi** : retirer les specs de `lua/plugins/legacy.lua` (telescope, telescope-fzf-native, telescope-ui-select,
vim-tmux-navigator), puis `:Lazy clean` et commiter `lazy-lock.json`.
