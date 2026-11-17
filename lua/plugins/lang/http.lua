-- Client HTTP dans Neovim : exécute les requêtes des fichiers .http
-- https://github.com/rest-nvim/rest.nvim (`:h rest-nvim`, `:Rest`)
-- Le rockspec du plugin est ignoré (luarocks désactivé dans lazy.lua) : dépendances déclarées ici.

-- Libs Lua pures (pas des plugins Neovim) : leurs modules sont à la racine du dépôt,
-- on ajoute donc ce dossier au package.path.
local function lua_lib(repo)
  return {
    repo,
    lazy = true,
    init = function(plugin)
      package.path = plugin.dir .. '/?.lua;' .. package.path
    end,
  }
end

return {
  'rest-nvim/rest.nvim',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'j-hui/fidget.nvim',
    lua_lib 'lunarmodules/lua-mimetypes', -- type MIME des corps lus depuis un fichier (`< ./fichier`)
    lua_lib 'manoelcampos/xml2lua', -- corps XML
  },
  ft = 'http',
  cmd = 'Rest',
  keys = {
    { '<leader>Rs', '<cmd>Rest run<cr>', desc = 'Envoyer la requête sous le curseur' },
    { '<leader>Rr', '<cmd>Rest last<cr>', desc = 'Rejouer la dernière requête' },
    { '<leader>Ro', '<cmd>Rest open<cr>', desc = 'Ouvrir le panneau de réponse' },
    { '<leader>Re', '<cmd>Rest env select<cr>', desc = 'Choisir le fichier .env' },
    { '<leader>Rl', '<cmd>Rest logs<cr>', desc = 'Logs rest.nvim' },
  },
  init = function()
    vim.g.rest_nvim = {}
    -- rest.nvim formate la réponse avec `gq` selon son type : jq pour le JSON (et le JSON-LD).
    if vim.fn.executable 'jq' == 1 then
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'json',
        callback = function(ev)
          vim.bo[ev.buf].formatprg = 'jq .'
        end,
      })
    end
  end,
}
