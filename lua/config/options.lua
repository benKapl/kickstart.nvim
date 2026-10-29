-- Options de l'éditeur. Aide : `:help option-list`, ou `:help 'nom'` pour une option.

-- Leader : espace (doit être défini avant le chargement des plugins)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Le terminal utilise une Nerd Font (icônes dans le picker, l'explorer, la statusline)
vim.g.have_nerd_font = true

-- Indentation par défaut : 2 espaces (guess-indent ajuste par fichier)
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.breakindent = true

-- Numéros de ligne relatifs, souris active, mode déjà affiché par la statusline
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.showmode = false

-- Presse-papiers système. Différé car le lancement du provider ralentit le démarrage.
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- WSL : win32yank plutôt que clip.exe/powershell (lent, et clip.exe casse l'UTF-8)
if vim.fn.has 'wsl' == 1 and vim.fn.executable 'win32yank.exe' == 1 then
  vim.g.clipboard = {
    name = 'win32yank',
    copy = {
      ['+'] = { 'win32yank.exe', '-i', '--crlf' },
      ['*'] = { 'win32yank.exe', '-i', '--crlf' },
    },
    paste = {
      ['+'] = { 'win32yank.exe', '-o', '--lf' },
      ['*'] = { 'win32yank.exe', '-o', '--lf' },
    },
    cache_enabled = 1,
  }
end

-- Historique d'annulation conservé entre les sessions
vim.o.undofile = true

-- Recherche insensible à la casse, sauf si le motif contient une majuscule
vim.o.ignorecase = true
vim.o.smartcase = true

-- Colonne de signes toujours visible (évite que le texte se décale)
vim.o.signcolumn = 'yes'

-- Délais : CursorHold (surlignage LSP) et attente des séquences de touches (which-key)
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Les nouveaux splits s'ouvrent à droite et en bas
vim.o.splitright = true
vim.o.splitbelow = true

-- Affiche tabulations, espaces en fin de ligne et espaces insécables
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Aperçu en direct des substitutions (:s) dans un split
vim.o.inccommand = 'split'

-- Ligne du curseur surlignée, 10 lignes de marge au scroll
vim.o.cursorline = true
vim.o.scrolloff = 10

-- Demande confirmation au lieu d'échouer (ex. :q avec des modifications non enregistrées)
vim.o.confirm = true
