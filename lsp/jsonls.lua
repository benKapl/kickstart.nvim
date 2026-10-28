-- Schémas JSON du catalogue SchemaStore (package.json, tsconfig.json, .eslintrc…)
return {
  before_init = function(_, config)
    config.settings.json.schemas = require('schemastore').json.schemas()
  end,
  settings = {
    json = { validate = { enable = true } },
  },
}
