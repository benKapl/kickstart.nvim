# Bases de données : vim-dadbod-ui

**Décision** : vim-dadbod + vim-dadbod-ui (`lua/plugins/db.lua`) pour explorer et requêter les bases depuis nvim,
chargés seulement sur les commandes `:DBUI*`. Connexions gardées dans `~/.local/share/db_ui/connections.json`
plutôt que dans `vim.g.dbs`, pour ne pas commiter de mots de passe.

**Piège rencontré** : une URL JDBC (`jdbc:mariadb://…`) ajoutée par `:DBUIAddConnection` est enregistrée sans
validation, puis fait planter chaque `:DBUI` (`E605: DB: no adapter for jdbc`). Correction à la main dans le fichier,
avec une URL dadbod (`mysql://root:…@127.0.0.1:4321/prod`) ; `127.0.0.1` car `localhost` force le socket Unix
du client `mysql` et ignore le port.

**Reste à faire** : vim-dadbod-completion est chargé sur les fichiers SQL mais n'est pas déclaré comme source
dans blink.cmp (`lua/plugins/completion.lua`), donc pas encore de complétion des tables et colonnes.
