-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = true

-- Set the minimum number of screen lines to keep above and below the cursor
vim.o.scrolloff = 10

-- Make relative line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Set the status line
vim.o.statusline = ''

-- Sets how Neovim will display certain whitespace in the editor.
-- See `:help 'list'` and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live
vim.o.inccommand = 'split'

-- Sync clipboard between OS and Neovim.
-- See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Set wrap behavior
vim.o.breakindent = true -- Indent wrapped lines

-- Enable line wrapping without breaking words
vim.o.wrap = true
vim.o.linebreak = true

-- Set wrap margin to 0 to ensure lines wrap exactly at the text width
vim.o.wrapmargin = 0

-- Set text width to 80 characters
vim.o.textwidth = 80

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Allows the current line number to be highlighted in transparent mode
vim.wo.cursorline = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 500

-- Hide the mode indicator in the command line
vim.o.showmode = false

-- Disabling Vim language providers for Python 3, Perl, Ruby, and Node.js
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-- Set the 'guicursor' option to control the cursor appearance in different modes
vim.o.guicursor = table.concat({
  'n-v-c:block-Cursor/lCursor-blinkwait500-blinkon100-blinkoff100', -- Normal mode
  'i-ci:ver25-Cursor/lCursor-blinkwait500-blinkon100-blinkoff100', -- Insert mode
  'r:hor50-Cursor/lCursor-blinkwait100-blinkon100-blinkoff100', -- Replace mode
}, ',')

-- Netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
