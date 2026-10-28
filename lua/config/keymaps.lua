-- Keymaps globales. Les keymaps propres à un plugin sont déclarées dans son fichier (lua/plugins/).
-- Liste complète : `<leader>sk`, ou which-key en appuyant sur <leader>.

local map = vim.keymap.set

-- Échap efface le surlignage de recherche
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostics du buffer dans la location list
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostics dans la location list' })

-- Sortie du mode terminal (:terminal) ; <C-\><C-n> fonctionne aussi
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Quitter le mode terminal' })

-- Navigation entre fenêtres nvim. Les panes tuios se pilotent à part (alt+flèches, ctrl+space h/j/k/l).
-- Tant que vim-tmux-navigator est installé (lua/plugins/legacy.lua), il remplace ces mappings.
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Fenêtre de gauche' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Fenêtre de droite' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Fenêtre du dessous' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Fenêtre du dessus' })
