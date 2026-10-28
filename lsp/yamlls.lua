-- Schémas YAML du catalogue SchemaStore (docker-compose, GitHub Actions…), via SchemaStore.nvim
-- plutôt que le téléchargement intégré de yamlls.
return {
  before_init = function(_, config)
    config.settings.yaml.schemas = require('schemastore').yaml.schemas()
  end,
  settings = {
    yaml = {
      schemaStore = { enable = false, url = '' },
    },
  },
}
