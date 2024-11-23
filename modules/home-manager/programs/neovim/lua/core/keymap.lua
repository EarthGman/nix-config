local keymap = require('vim.keymap')

vim.g.mapleader = " "
keymap.set("n", "<leader>pv", vim.cmd.Ex) --go to project view / builtin file tree
keymap.set("n", "<leader>vs", ":vsplit<CR>", {})
keymap.set("n", "<leader>hs", ":sp<CR>", {})

-- move between windows (Alt + hjkl)
keymap.set('n', '<A-h>', '<C-w>h', {})
keymap.set('n', '<A-j>', '<C-w>j', {})
keymap.set('n', '<A-k>', '<C-w>k', {})
keymap.set('n', '<A-l>', '<C-w>l', {})

keymap.set("n", "<leader>w", ":w<CR>", {})   --save file
keymap.set("n", "<leader>y", ":%y+<CR>", {}) --yank whole file
