-- Keymaps globales. Les keymaps propres à un plugin sont déclarées dans son fichier (lua/plugins/).
-- Liste complète : `<leader>sk`, ou which-key en appuyant sur <leader>.

local map = vim.keymap.set

-- Échap efface le surlignage de recherche
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostics du buffer dans la location list
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostics dans la location list' })

-- Sortie du mode terminal (:terminal) ; <C-\><C-n> fonctionne aussi
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Quitter le mode terminal' })

-- Navigation entre fenêtres nvim (<C-h/j/k/l>) : gérée par tuios-nvim-navigator (lua/plugins/tuios.lua),
-- qui bascule sur le pane tuios adjacent au bord de l'écran.

-- Navigation vers le fichier précédent
map('n', '<leader>bb', '<cmd>e #<CR>', { desc = 'Fichier précédent (alternate)' })

-- Onglets (tabs). Passer de l'un à l'autre : gt / gT, ou 3gt pour le 3ᵉ.
map('n', '<leader>Tn', '<cmd>tabnew<CR>', { desc = 'Nouvel onglet' })
map('n', '<leader>Ts', '<cmd>tab split<CR>', { desc = 'Buffer courant dans un nouvel onglet' })
map('n', '<leader>Tc', '<cmd>tabclose<CR>', { desc = "Fermer l'onglet" })
