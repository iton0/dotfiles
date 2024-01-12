-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = true

-- Set the minimum number of screen lines to keep above and below the cursor
vim.o.scrolloff = 8

-- Make relative line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Tabs and Indentation
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.autoindent = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Set the status line
vim.o.statusline = ''

-- Sync clipboard between OS and Neovim.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Set wrap options
vim.o.wrap = true -- Enable line wrapping
vim.o.linebreak = true -- Wrap lines at word boundaries

-- Set wrap behavior
vim.o.breakindent = true -- Indent wrapped lines
vim.o.showbreak = ' ↪ ' -- Symbol to indicate wrapped lines

-- Set text width to 80 characters
vim.o.textwidth = 80

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Enable cursorline highlighting
vim.wo.cursorline = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 500

-- Hide the mode indicator in the command line
vim.o.showmode = false

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,menuone,preview,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Disabling Vim language providers for Python 3, Perl, Ruby, and Node.js
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-- Set the 'guicursor' option to control the cursor appearance in different modes
vim.o.guicursor = table.concat({
  'n-v-c:block-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100', -- Normal mode
  'i-ci:ver25-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100', -- Insert mode
  'r:hor50-Cursor/lCursor-blinkwait100-blinkon100-blinkoff100', -- Replace mode
}, ',')

-- Netrw
vim.g.netrw_banner = 0 -- Remove the directory banner
vim.o.laststatus = 0 -- Remove status line
