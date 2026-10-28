# Commande `e` : ouvrir un fichier dans le nvim de la session tuios

**Décision** : le premier nvim d'une session tuios écoute sur `$XDG_RUNTIME_DIR/nvim-<session>.sock`
(`lua/config/autocmds.lua`). `bin/e fichier`, depuis un autre pane, l'ouvre dans ce nvim et lui donne le focus
(`tuios focus-window`). Sans nvim dans la session, `e` lance nvim.
