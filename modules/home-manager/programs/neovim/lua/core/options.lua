local opt = vim.opt

vim.wo.number = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.mouse = "a"               --mouse support in all modes (why not?)
opt.clipboard = "unnamedplus" --allow nvim to inherit the system clipboard
opt.wrap = false
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.hlsearch = false
opt.incsearch = true
