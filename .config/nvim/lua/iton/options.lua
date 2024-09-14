-- [[ Leader Keys ]]
-- Set <space> as the leader key
-- NOTE: needs to be done first
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.scrolloff = 10

vim.wo.number = true
vim.wo.relativenumber = true

vim.o.statusline = '%=%m%='
vim.o.laststatus = 3

vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.o.breakindent = true

vim.o.wrap = true
vim.o.linebreak = true

vim.o.showmode = false

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.updatetime = 250
vim.o.timeoutlen = 350

vim.wo.signcolumn = 'yes'

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-- Disable language related options
vim.g.zig_fmt_parse_errors = 0

vim.o.guicursor = table.concat({
  'n-v-c:block-Cursor/lCursor-blinkwait500-blinkon100-blinkoff100',
  'i-ci:ver25-Cursor/lCursor-blinkwait500-blinkon100-blinkoff100',
  'r:hor50-Cursor/lCursor-blinkwait100-blinkon100-blinkoff100',
}, ',')

vim.opt.fillchars:append('eob: ')
