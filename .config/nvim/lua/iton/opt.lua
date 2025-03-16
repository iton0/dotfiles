local g = vim.g
g.mapleader = " "
g.maplocalleader = " "
local o = vim.o
o.signcolumn = "yes" .. require("iton.util").signcol_size
o.scrolloff = 10
o.splitbelow = true
o.splitright = true
o.tabstop = 4
o.shiftwidth = 4
o.linebreak = true
o.inccommand = "split"
o.showmode = false
o.undofile = true
o.timeoutlen = 400
o.ignorecase = true
o.smartcase = true
o.statusline = "%.30f %h%r%m%=%3l:%-2c"
