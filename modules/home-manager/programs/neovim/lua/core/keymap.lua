vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex) --go to project view / builtin file tree
vim.api.nvim_set_keymap("n", "<leader>w", ":w<CR>", { noremap = true, silent = true }) --save file
vim.api.nvim_set_keymap("n", "<leader>y", ":%y+<CR>", { noremap = true, silent = true }) --yank whole file
