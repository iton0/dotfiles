-- Set the minimum number of screen lines to keep above and below the cursor
vim.o.scrolloff = 10

-- Make relative line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Makes default statusline empty
vim.o.statusline = ' '

-- Sets how Neovim will display certain whitespace in the editor.
-- See `:help 'list'` and `:help 'listchars'`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live
vim.o.inccommand = 'split'

-- Sync clipboard between OS and Neovim.
-- See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

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
vim.o.timeoutlen = 500

-- Configure how new splits should be opened
vim.o.splitright = true

-- Hide the mode indicator in the command line
vim.o.showmode = false

-- Set the 'guicursor' option to control the cursor appearance in different modes
vim.o.guicursor = table.concat({
  'n-v-c:block-Cursor/lCursor-blinkwait500-blinkon100-blinkoff100', -- Normal mode
  'i-ci:ver25-Cursor/lCursor-blinkwait500-blinkon100-blinkoff100', -- Insert mode
  'r:hor50-Cursor/lCursor-blinkwait100-blinkon100-blinkoff100', -- Replace mode
}, ',')

-- Hide the banner (if you want). To show it temporarily you can use I inside Netrw.
vim.g.netrw_banner = 0

-- Set the End-of-Buffer (EOB) character to an empty space for a cleaner appearance
vim.opt.fillchars:append({ eob = ' ' })
