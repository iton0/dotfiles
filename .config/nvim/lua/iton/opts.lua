local opt = vim.opt
local g = vim.g
local o = vim.o

-- Leader Keys
g.mapleader = ' '
g.maplocalleader = ' '

-- General options
opt.scrolloff = 10
opt.statusline = ' '
opt.number = true
opt.relativenumber = true
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
opt.breakindent = true
opt.wrap = true
opt.linebreak = true
opt.inccommand = 'split'
opt.showmode = false
opt.clipboard = 'unnamedplus'
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.updatetime = 250
opt.timeoutlen = 350
opt.signcolumn = 'yes'
opt.splitright = true
opt.splitbelow = true

-- Providers
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0

-- Additional settings
g.zig_fmt_parse_errors = 0

-- Cursor settings
o.guicursor = table.concat({
  'n-v-c:block-Cursor/lCursor-blinkwait500-blinkon100-blinkoff100',
  'i-ci:ver25-Cursor/lCursor-blinkwait500-blinkon100-blinkoff100',
  'r:hor50-Cursor/lCursor-blinkwait100-blinkon100-blinkoff100',
}, ',')

opt.fillchars:append('eob: ')
