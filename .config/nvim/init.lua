local background_var = "light" -- default/fallback background

do
        local fd = vim.uv.fs_open(
                vim.fs.normalize((vim.env.XDG_CACHE_HOME or (vim.env.HOME .. "/.cache")) .. "/nvim_theme"), "r",
                438)

        if fd then
                local stat = vim.uv.fs_fstat(fd)
                if stat and stat.size > 0 then
                        local content = vim.uv.fs_read(fd, stat.size, 0)
                        if content then
                                local clean_bg = vim.trim(content)
                                if clean_bg == "light" or clean_bg == "dark" then
                                        background_var = clean_bg
                                end
                        end
                end
                vim.uv.fs_close(fd)
        end
end

local g = vim.g
local o = vim.o

-- Global Leader Key
g.mapleader = " "

-- Disable Remote Providers
g.loaded_python_provider = 0
g.loaded_python3_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- Disable builtin vim plugins (performance)
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_tutor_mode_plugin = 1
g.loaded_2html_plugin = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_gzip = 1
g.loaded_logipat = 1
g.loaded_rrhelper = 1
g.loaded_spellfile_plugin = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1

o.background = background_var                          -- Editor background color
o.signcolumn = "yes:5"                                 -- Fixed width signcolumn
o.confirm = true                                       -- Prompt to save on exit
o.pumheight = 10                                       -- Popup menu max height
o.winborder = "bold"                                   -- Border style
o.helpheight = 0                                       -- Auto-size help
o.shortmess = "CFOWacoI"                               -- Minimize messages
o.fillchars = "eob: "                                  -- Don't show `~` outside of buffer
o.showmode = false                                     -- Don't show mode in command line
o.completeopt = "menu,menuone,noselect,noinsert,fuzzy" -- Completion style
o.wildmode = "noselect,full"                           -- Command line completion style
o.wildoptions = "pum,fuzzy"                            -- Enable fuzzy matching in native menus
o.virtualedit = "block"                                -- Free cursor in visual block
o.formatoptions = "rqnl1j"                             -- Formatting logic
o.textwidth = 80                                       -- Max width
o.wrap = false                                         -- Global no-wrap
o.scrolloff = 10                                       -- Vertical padding
o.sidescrolloff = 10                                   -- Horizontal padding
o.splitbelow = true                                    -- Split horizontal below
o.splitright = true                                    -- Split vertical right
o.splitkeep = "screen"                                 -- Stable scroll on split
o.expandtab = true                                     -- Use spaces
o.softtabstop = 8                                      -- Edit-time tab size
o.shiftwidth = 8                                       -- Indent size
o.tabstop = 8                                          -- Visual tab size
o.ignorecase = true                                    -- Case-insensitive search
o.smartcase = true                                     -- Case-sensitive if caps present
o.inccommand = "split"                                 -- Live substitute preview
o.infercase = true                                     -- Match case in completion
o.timeoutlen = 500                                     -- Mapping wait
o.ttimeoutlen = 0                                      -- Key code wait
o.undofile = true                                      -- Persistent undo
o.swapfile = false                                     -- No swap
o.writebackup = false                                  -- No backup
o.mouse = ""                                           -- Disable mouse
o.maxmempattern = 20000                                -- Regex memory
o.synmaxcol = 300                                      -- Syntax limit
o.shada = "'50,<50,s10,h"                              -- Caps history, files, registers

require("mini.deps").setup()
local add = MiniDeps.add
add("https://github.com/nvim-mini/mini.nvim")
add("https://codeberg.org/mfussenegger/nvim-lint")
add("https://github.com/christoomey/vim-tmux-navigator")

-- vim.pack.add({
--         "https://github.com/nvim-mini/mini.nvim",
--         "https://codeberg.org/mfussenegger/nvim-lint",
--         "https://github.com/christoomey/vim-tmux-navigator"
-- })

-- Colorscheme
vim.cmd.colorscheme("fovea")
