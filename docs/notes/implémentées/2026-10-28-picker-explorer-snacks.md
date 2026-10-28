# Picker et arbre de fichiers : snacks.nvim

**Décision** : snacks.nvim fournit le picker (fichiers, grep, LSP, git), l'explorer (`<leader>e`) et lazygit
(`<leader>gg`). Telescope est conservé sous `<leader>T…` le temps de comparer (voir legacy).

**Alternatives écartées** : garder Telescope (plus lent, pas d'arbre), fzf-lua (pas d'arbre),
neo-tree (plus lourd ; l'explorer snacks suffit).

**Oil** reste pour renommer / déplacer en masse (`-`) et pour ouvrir les dossiers.
