local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader><Space>', builtin.find_files, {}) --telescope file browser
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})         --buffers
vim.keymap.set('n', '<leader>lg', builtin.live_grep, {})
