# Structure modulaire (base kickstart)

**Décision** : garder kickstart comme base mais découper le `init.lua` monolithique (965 lignes) en
`lua/config/*` et un fichier par domaine dans `lua/plugins/`. Commentaires de tutoriel retirés.

**Pourquoi** : config lisible et maintenable, sans la couche d'abstraction d'une distribution (LazyVim écarté).

**Supprimé** : `lua/kickstart/`, `lua/custom/`, `doc/kickstart.txt` (fichiers inutilisés ou déplacés),
autocmd `TmuxCwdSync` (ne s'exécutait que si `$TMUX` est défini, jamais sous tuios).
