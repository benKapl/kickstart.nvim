-- Édition de texte : text objects, surround, paires de caractères, détection de l'indentation, statusline.

return {
  { -- Détecte l'indentation (tabs/espaces, largeur) de chaque fichier ouvert
    -- https://github.com/NMAC427/guess-indent.nvim
    'NMAC427/guess-indent.nvim',
    opts = {},
  },

  { -- Ferme automatiquement (), [], {}, '', ""
    -- https://github.com/windwp/nvim-autopairs
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },

  { -- Collection de petits modules. https://github.com/echasnovski/mini.nvim
    'echasnovski/mini.nvim',
    config = function()
      -- Text objects étendus : va) vi' ci" yinq (next quote)…  `:help mini.ai`
      require('mini.ai').setup { n_lines = 500 }

      -- Surround : saiw) ajoute, sd' supprime, sr)' remplace.  `:help mini.surround`
      require('mini.surround').setup()

      -- Statusline : mode, branche git, diagnostics, fichier, position ligne:colonne
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end
    end,
  },
}
