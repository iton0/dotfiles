local global = vim.g
local option = vim.o

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
global.loaded_tutor_mode_plugin = 1
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
local background_var = "light" -- default/fallback
local theme_path = vim.fs.normalize((vim.env.XDG_CACHE_HOME or (vim.fn.expand("~") .. "/.cache")) .. "/nvim_theme")

local f = io.open(theme_path, "r")
if f then
	local content = f:read("*l")
	f:close()
	if content then
		local clean_bg = content:gsub("%s+", "")
		if clean_bg == "dark" or clean_bg == "light" then
			background_var = clean_bg
		end
	end
end

-- UI and Appearance
option.background = background_var -- Editor background color
option.signcolumn = "yes:5" -- Fixed width signcolumn
option.confirm = true -- Prompt to save on exit
option.pumheight = 10 -- Popup menu max height
option.winborder = "bold" -- Border style
option.helpheight = 0 -- Auto-size help
option.shortmess = "CFOWacoI" -- Minimize messages
option.fillchars = "eob: " -- Don't show `~` outside of buffer
option.showmode = false -- Don't show mode in command line
option.smoothscroll = true -- Pixel-perfect scrolling

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
option.tabline = "%!v:lua.MyTabline()"

-- Editor Behavior
option.completeopt = "menu,menuone,noselect,noinsert,fuzzy" -- Completion style
option.wildmode = "noselect,full" -- Command line completion style
option.wildoptions = "pum,fuzzy" -- Enable fuzzy matching in native menus
option.virtualedit = "block" -- Free cursor in visual block
option.formatoptions = "rqnl1j" -- Formatting logic
option.textwidth = 80 -- Max width
option.wrap = false -- Global no-wrap
option.scrolloff = 10 -- Vertical padding
option.sidescrolloff = 10 -- Horizontal padding
option.splitbelow = true -- Split horizontal below
option.splitright = true -- Split vertical right
option.splitkeep = "screen" -- Stable scroll on split

-- Tabs and Indent
option.expandtab = true -- Use spaces
option.softtabstop = 8 -- Edit-time tab size
option.shiftwidth = 8 -- Indent size
option.tabstop = 8 -- Visual tab size

-- Search and Command Line
option.ignorecase = true -- Case-insensitive search
option.smartcase = true -- Case-sensitive if caps present
option.inccommand = "split" -- Live substitute preview
option.infercase = true -- Match case in completion

-- System and Performance
option.updatetime = 250 -- CursorHold delay
option.timeoutlen = 500 -- Mapping wait
option.ttimeoutlen = 0 -- Key code wait
option.undofile = true -- Persistent undo
option.swapfile = false -- No swap
option.writebackup = false -- No backup
option.shada = "'100,<50,s10,:100" -- History limits
option.mouse = "" -- Disable mouse
option.maxmempattern = 20000 -- Regex memory
option.synmaxcol = 300 -- Syntax limit

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
