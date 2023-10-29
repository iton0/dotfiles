-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- Make relative line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Set wrap options
vim.opt.wrap = true      -- Enable line wrapping
vim.opt.linebreak = true -- Wrap lines at word boundaries

-- Set wrap behavior
vim.opt.breakindent = true -- Indent wrapped lines
vim.opt.showbreak = " ↪ " -- Symbol to indicate wrapped lines

-- Save undo history
vim.o.undofile = true

-- Automatically save files on buffer switch or exist
vim.o.autowrite = true

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

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Set Python executable
vim.g.python3_host_prog = '/usr/bin/python3'
