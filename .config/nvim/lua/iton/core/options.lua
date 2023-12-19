-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- Make relative line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Tabs and Identation
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.autoindent = true

-- Enable mouse mode
vim.o.mouse = 'a'

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

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,menuone,preview,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Set fold options for fold.lua
vim.o.fillchars = [[eob: ,fold: ,foldopen: ,foldsep: ,foldclose: ]]
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
