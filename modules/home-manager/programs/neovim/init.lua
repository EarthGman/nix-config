vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("core.keymaps")

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

--vim.keymap.set("n", "<leader>fb", tbi.buffers, { desc = "Find Buffers" })
--vim.keymap.set("n", "<leader>fh", tbi.help_tags, { desc = "Find Help" })

