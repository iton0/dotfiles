-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

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

-- Set fold options for fold.lua
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.fillchars = [[eob: ,fold: ,foldopen: ,foldsep: ,foldclose: ]]
vim.o.foldtext = 'v:lua.MyFoldText()'
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.nofoldenable = true

-- Disabling Vim language providers for Python 3, Perl, Ruby, and Node.js
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-- Netrw
vim.g.netrw_liststyle = 3 -- Set netrw_liststyle to tree list view
vim.g.netrw_banner = 0 -- Remove the directory banner
vim.o.laststatus = 0 -- Remove status line
