local global = vim.g
local opt = vim.o

-- Global Leader Key
global.mapleader = " "

-- Disable Remote Providers
global.loaded_python_provider = 0
global.loaded_python3_provider = 0
global.loaded_node_provider = 0
global.loaded_perl_provider = 0
global.loaded_ruby_provider = 0

-- Disable builtin vim plugins (performance)
global.loaded_netrw = 1
global.loaded_netrwPlugin = 1
global.loaded_2html_plugin = 1
global.loaded_getscript = 1
global.loaded_getscriptPlugin = 1
global.loaded_gzip = 1
global.loaded_logipat = 1
global.loaded_rrhelper = 1
global.loaded_spellfile_plugin = 1
global.loaded_tar = 1
global.loaded_tarPlugin = 1
global.loaded_vimball = 1
global.loaded_vimballPlugin = 1
global.loaded_zip = 1
global.loaded_zipPlugin = 1

-- Set background
local bg_to_apply = "light" -- default/fallback
local theme_path = vim.fs.normalize((vim.env.XDG_CACHE_HOME or (vim.fn.expand("~") .. "/.cache")) .. "/nvim_theme")

local f = io.open(theme_path, "r")
if f then
	local content = f:read("*l")
	f:close()
	if content then
		local clean_bg = content:gsub("%s+", "")
		if clean_bg == "dark" or clean_bg == "light" then
			bg_to_apply = clean_bg
		end
	end
end

-- UI and Appearance
opt.background = bg_to_apply -- Editor background color
opt.signcolumn = "yes:5" -- Fixed width signcolumn
opt.pumheight = 10 -- Popup menu max height
opt.winborder = "bold" -- Border style
opt.helpheight = 0 -- Auto-size help
opt.shortmess = "CFOWacoI" -- Minimize messages
opt.fillchars = "eob: " -- Don't show `~` outside of buffer
opt.showmode = false -- Don't show mode in command line
opt.smoothscroll = true -- Pixel-perfect scrolling

-- Custom tabline
local function my_custom_tabline()
	local segments = {}
	local tabpages = vim.api.nvim_list_tabpages()
	local current_tab = vim.api.nvim_get_current_tabpage()

	for i, tabpage in ipairs(tabpages) do
		local is_selected = (tabpage == current_tab)
		local hl = is_selected and "%#TabLineSel#" or "%#TabLine#"

		table.insert(segments, hl)
		table.insert(segments, "%" .. i .. "T") -- Clickable
		table.insert(segments, " [" .. i .. "]") -- Dynamic Number

		local win = vim.api.nvim_tabpage_get_win(tabpage)
		local buf = vim.api.nvim_win_get_buf(win)
		local name = vim.api.nvim_buf_get_name(buf)

		if name ~= "" then
			table.insert(segments, " " .. vim.fn.fnamemodify(name, ":t") .. " ")
		else
			table.insert(segments, " [No Name] ")
		end

		local is_modified = false
		for _, bufnr in ipairs(vim.fn.tabpagebuflist(i)) do
			if vim.api.nvim_get_option_value("modified", { buf = bufnr }) then
				is_modified = true
				break
			end
		end
		if is_modified then
			table.insert(segments, "+ ")
		end

		if i < #tabpages then
			table.insert(segments, "%#TabLine#|")
		end
	end

	table.insert(segments, "%#TabLineFill#%T")
	return table.concat(segments)
end

_G.MyTabline = my_custom_tabline
opt.tabline = "%!v:lua.MyTabline()"

-- Editor Behavior
opt.completeopt = "menuone,noselect,noinsert,fuzzy" -- Completion style
opt.wildmode = "noselect,full" -- Command line completion style
opt.wildoptions = "pum,fuzzy" -- Enable fuzzy matching in native menus
opt.virtualedit = "block" -- Free cursor in visual block
opt.formatoptions = "rqnl1j" -- Formatting logic
opt.textwidth = 80 -- Max width
opt.wrap = false -- Global no-wrap
opt.scrolloff = 999 -- Vertical padding
opt.sidescrolloff = 10 -- Horizontal padding
opt.splitbelow = true -- Split horizontal below
opt.splitright = true -- Split vertical right
opt.splitkeep = "screen" -- Stable scroll on split

-- Tabs and Indent
opt.expandtab = true -- Use spaces
opt.softtabstop = 8 -- Edit-time tab size
opt.shiftwidth = 8 -- Indent size
opt.tabstop = 8 -- Visual tab size

-- Search and Command Line
opt.ignorecase = true -- Case-insensitive search
opt.smartcase = true -- Case-sensitive if caps present
opt.inccommand = "split" -- Live substitute preview
opt.infercase = true -- Match case in completion

-- System and Performance
opt.updatetime = 1000 -- CursorHold delay
opt.timeoutlen = 500 -- Mapping wait
opt.ttimeoutlen = 0 -- Key code wait
opt.undofile = true -- Persistent undo
opt.swapfile = false -- No swap
opt.writebackup = false -- No backup
opt.shada = "'100,<50,s10,:100" -- History limits
opt.mouse = "" -- Disable mouse
opt.maxmempattern = 20000 -- Regex memory
opt.synmaxcol = 300 -- Syntax limit

-- Diagnostics
vim.diagnostic.config({
	signs = { severity = { min = vim.diagnostic.severity.INFO } },
	underline = true,
	virtual_lines = false,
	virtual_text = {
		current_line = true,
		severity = { min = vim.diagnostic.severity.ERROR },
	},
	float = {
		style = "minimal",
		source = true,
		header = "",
		prefix = "",
	},
	update_in_insert = false,
	severity_sort = true,
})

-- Colorscheme
vim.cmd.colorscheme("fovea")
