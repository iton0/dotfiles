-- Set <space> as the leader key
-- NOTE: needs to be done first
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set the minimum number of screen lines to keep above and below the cursor
vim.o.scrolloff = 10

-- Make relative line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Make default statusline cleaner for oil.nvim
vim.o.statusline = '%=%m%=%s'
vim.o.laststatus = 3

-- Sets how Neovim will display certain whitespace in the editor.
-- See `:help 'list'` and `:help 'listchars'`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live
vim.o.inccommand = 'split'

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Enable line wrapping without breaking words
vim.o.wrap = true
vim.o.linebreak = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 350

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Hide the mode indicator in the command line
vim.o.showmode = false

-- Disable unused language providers to improve performance
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-- Disable language related options
vim.g.zig_fmt_parse_errors = 0

-- Set the 'guicursor' option to control the cursor appearance in different modes
vim.o.guicursor = table.concat({
  'n-v-c:block-Cursor/lCursor-blinkwait500-blinkon100-blinkoff100', -- Normal mode
  'i-ci:ver25-Cursor/lCursor-blinkwait500-blinkon100-blinkoff100', -- Insert mode
  'r:hor50-Cursor/lCursor-blinkwait100-blinkon100-blinkoff100', -- Replace mode
}, ',')

-- Hide the banner (if you want). To show it temporarily you can use I inside Netrw.
vim.g.netrw_banner = 0
