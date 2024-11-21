local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader><Space>', builtin.find_files, {}) --telescope file browser

--vim.keymap.set('n', '<C-p>', builtin.git_files, {}) --throws error atm

vim.keymap.set('n', '<leader>lg', function() --live grep with telescope
  builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
