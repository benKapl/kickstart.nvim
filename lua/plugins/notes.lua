-- Notes zk : intégration du CLI zk (https://zk-org.github.io/zk/) : LSP (complétion des liens [[…]],
-- diagnostics de liens morts, aperçu au survol avec K) et pickers snacks pour les notes, tags, liens.
-- Le binaire `zk` doit être dans le PATH ; la config du carnet vit dans <carnet>/.zk/config.toml.
-- Hors d'un carnet, les commandes globales visent $ZK_NOTEBOOK_DIR s'il est défini, sinon le dossier courant.
-- Doc : `:help zk` — https://github.com/zk-org/zk-nvim

-- Demande un titre dans une saisie flottante (snacks input) puis appelle la commande zk `cmd`
-- avec les options + titre. Les commandes « Selection » lisent les marques '< et '>.
local function with_title(cmd, opts)
  vim.ui.input({ prompt = 'Titre : ' }, function(title)
    if not title or title == '' then
      return
    end
    require('zk.commands').get(cmd)(vim.tbl_extend('force', opts or {}, { title = title }))
  end)
end

-- Keymaps posées seulement sur les buffers Markdown qui appartiennent à un carnet zk
local function notebook_keymaps(buf)
  local map = function(mode, keys, func, desc)
    vim.keymap.set(mode, keys, func, { buffer = buf, desc = 'zk: ' .. desc })
  end
  local here = function()
    return vim.fn.expand '%:p:h'
  end

  map('n', '<leader>zN', function()
    with_title('ZkNew', { dir = here() })
  end, 'Nouvelle note dans ce dossier')
  map('x', '<leader>zt', ":'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<cr>", 'Note avec la sélection pour titre')
  map('x', '<leader>zc', function()
    vim.cmd 'normal! \27' -- quitte le mode visuel pour fixer les marques '< et '>
    with_title('ZkNewFromContentSelection', { dir = here() })
  end, 'Note avec la sélection pour contenu')
  map('x', '<leader>zi', ":'<,'>ZkInsertLinkAtSelection<cr>", 'Lier la sélection à une note')
  map('n', '<leader>zi', '<cmd>ZkInsertLink<cr>', 'Insérer un lien vers une note')
  map('n', '<leader>zb', '<cmd>ZkBacklinks<cr>', 'Backlinks (notes qui pointent ici)')
  map('n', '<leader>zl', '<cmd>ZkLinks<cr>', 'Liens sortants de cette note')
end

return {
  'zk-org/zk-nvim',
  ft = 'markdown',
  cmd = { 'ZkNew', 'ZkNotes', 'ZkTags', 'ZkIndex' },
  keys = {
    {
      '<leader>zn',
      function()
        with_title 'ZkNew'
      end,
      desc = 'Nouvelle note',
    },
    { '<leader>zo', "<cmd>ZkNotes { sort = { 'modified' } }<cr>", desc = 'Ouvrir une note' },
    { '<leader>zT', '<cmd>ZkTags<cr>', desc = 'Notes par tag' },
    {
      '<leader>zf',
      function()
        vim.ui.input({ prompt = 'Chercher dans les notes : ' }, function(q)
          if q and q ~= '' then
            require('zk.commands').get 'ZkNotes' { sort = { 'modified' }, match = { q } }
          end
        end)
      end,
      desc = 'Chercher dans le contenu des notes',
    },
  },
  config = function()
    require('zk').setup {
      picker = 'snacks_picker',
      lsp = {
        config = {
          cmd = { 'zk', 'lsp' },
          name = 'zk',
          capabilities = require('blink.cmp').get_lsp_capabilities(),
        },
        auto_attach = { enabled = true, filetypes = { 'markdown' } },
      },
    }

    -- Keymaps de carnet : uniquement si le fichier est dans un carnet zk (dossier parent avec .zk/)
    local function attach(buf)
      if require('zk.util').notebook_root(vim.api.nvim_buf_get_name(buf)) then
        notebook_keymaps(buf)
      end
    end
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('config-zk-keymaps', { clear = true }),
      pattern = 'markdown',
      callback = function(ev)
        attach(ev.buf)
      end,
    })
    -- Le buffer qui a déclenché le chargement (ft = markdown) a déjà passé son FileType
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.bo[buf].filetype == 'markdown' then
        attach(buf)
      end
    end
  end,
}
