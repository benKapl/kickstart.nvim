-- Point d'entrée. L'ordre compte : leader et options avant les plugins.
-- Organisation et fonctionnalités : README.md et docs/features.md.

require 'config.options' -- options vim, leader, presse-papiers
require 'config.keymaps' -- keymaps globales
require 'config.autocmds' -- autocommandes, socket serveur par session tuios
require 'config.lazy' -- plugins (lua/plugins/*.lua)
