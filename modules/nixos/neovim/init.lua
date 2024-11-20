vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt
opt.relativenumber = true
opt.number = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
vim.bo.softtabstop = 2
opt.cursorline = true
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
vim.diagnostic.config {
  float = { boarder = "rounded" }
}
opt.backspace = "indent,eol,start"
opt.clipboard:append("unnamedplus")
opt.splitright = true
opt.splitbelow = true
opt.iskeyword:append("-")
opt.foldlevel = 20
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader><Space>', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>lg', function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
