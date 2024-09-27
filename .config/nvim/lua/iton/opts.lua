local o = vim.opt
local g = vim.g

-- Leader Keys
g.mapleader = ' '
g.maplocalleader = ' '

-- General options
o.scrolloff = 10
o.statusline = ' '
o.number = true
o.relativenumber = true
o.breakindent = true
o.wrap = true
o.linebreak = true
o.inccommand = 'split'
o.showmode = false
o.clipboard = 'unnamedplus'
o.undofile = true
o.ignorecase = true
o.smartcase = true
o.updatetime = 250
o.timeoutlen = 500
o.signcolumn = 'yes'

-- Providers
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0
