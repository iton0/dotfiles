local g = vim.g
local o = vim.o

g.mapleader = " "
g.maplocalleader = " "
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0

o.complete = ""
o.signcolumn = "yes" .. require("iton.util").signcol_size
o.scrolloff = 9
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