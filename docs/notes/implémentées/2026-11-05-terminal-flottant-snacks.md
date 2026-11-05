# Terminal flottant : snacks.terminal

**Décision** : `<leader>tt` bascule un terminal flottant avec `Snacks.terminal.toggle(nil, { win = { position = 'float' } })`
(`lua/plugins/snacks.lua`), plutôt qu'un plugin dédié (toggleterm) : snacks est déjà chargé. Rangé dans le groupe
`<leader>t` (Toggle) de which-key.

**Apparence** : `border = 'rounded'` et bordure en `#E6B450`, l'accent Ayu déjà utilisé par colorful-winsep pour le
pane actif. Le groupe `SnacksTerminalBorder` est redéfini à chaque ouverture pour survivre à un `:colorscheme`.
`wo.winhighlight` remplace entièrement la valeur par défaut de snacks : on y reprend `Normal` / `NormalNC` en plus de
`FloatBorder`.

**Limite** : `<leader>tt` ne marche qu'en mode normal ; depuis le terminal, `<Esc><Esc>` puis `q` ou `<leader>tt`.
