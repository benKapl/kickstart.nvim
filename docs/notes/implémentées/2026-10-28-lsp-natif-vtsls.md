# LSP : API native nvim 0.11 et vtsls

**Décision** : `vim.lsp.config` / `vim.lsp.enable` + `lsp/<serveur>.lua`, mason-lspconfig v2 (installation seule,
`automatic_enable = false`). Serveurs : vtsls, eslint, lua_ls, gopls, jsonls, yamlls, bashls (+ SchemaStore).

**Pourquoi** : l'ancien modèle (handlers mason-lspconfig v1) cassait à la mise à jour. vtsls se comporte
comme VS Code / Zed ; ts_ls reste installé par mason mais n'est plus démarré.

**Découvert** : gopls ne démarrait pas avant (go.nvim a `lsp_cfg = false` par défaut). Il est maintenant
démarré par lsp.lua ; le formatage Go passe par conform (goimports) au lieu de l'autocmd de go.nvim.
Les codelens de go.nvim sont désactivées (API de nvim 0.12).
