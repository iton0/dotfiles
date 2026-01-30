local g, o, ol = vim.g, vim.o, vim.opt_local
local later, autocmd, usercmd = _G.MyConfig.later, _G.MyConfig.new_autocmd, vim.api.nvim_create_user_command

local system_theme = (function()
	local theme_cache = vim.fn.expand("~/.cache/nvim_theme")
	local f = io.open(theme_cache, "r")
	if f then
		local content = f:read("*all"):gsub("%s+", "")
		f:close()
		if content ~= "" then
			return content
		end
	end
	return "light"
end)()

-- Keymap Leaders
g.mapleader = " " -- Global leader
g.maplocalleader = " " -- Local leader

-- Disable Built-in Plugins
g.loaded_netrw = 1 -- Disable netrw explorer
g.loaded_netrwPlugin = 1 -- Disable netrw plugin
g.loaded_tutor_mode_plugin = 1 -- Disable tutor

-- Disable Remote Providers
g.loaded_python_provider = 0 -- Disable python2
g.loaded_python3_provider = 0 -- Disable python3
g.loaded_node_provider = 0 -- Disable node
g.loaded_perl_provider = 0 -- Disable perl
g.loaded_ruby_provider = 0 -- Disable ruby

-- UI and Appearance
o.background = system_theme -- Dynamic theme source
o.signcolumn = "yes:4" -- Fixed width signcolumn
o.cursorline = true -- Highlight line
o.cursorlineopt = "screenline,number" -- Screen-relative highlight
o.number = true -- Line numbers
o.showmode = false -- Hide mode string
o.pumheight = 10 -- Popup menu max height
o.winborder = "bold" -- Border style
o.helpheight = 0 -- Auto-size help
o.shortmess = "CFOSWaco" -- Minimize messages
o.ruler = false -- Don't show cursor coordinates

vim.cmd.colorscheme("helium")

-- Editor Behavior
o.completeopt = "menuone,noinsert,fuzzy,nosort,popup" -- Completion style
o.virtualedit = "block" -- Free cursor in visual block
o.formatoptions = "rqnl1j" -- Formatting logic
o.textwidth = 80 -- Max width
o.wrap = false -- Global no-wrap
o.smoothscroll = true -- Pixel-level scroll
o.scrolloff = 10 -- Vertical padding
o.sidescrolloff = 10 -- Horizontal padding
o.splitbelow = true -- Split horizontal below
o.splitright = true -- Split vertical right
o.splitkeep = "screen" -- Stable scroll on split

-- Tabs and Indent
o.expandtab = true -- Use spaces
o.softtabstop = 4 -- Edit-time tab size
o.shiftwidth = 4 -- Indent size
o.tabstop = 4 -- Visual tab size

-- Search and Command Line
o.ignorecase = true -- Case-insensitive search
o.smartcase = true -- Case-sensitive if caps present
o.inccommand = "split" -- Live substitute preview
o.infercase = true -- Match case in completion
o.wildmode = "longest:full,full" -- Command completion style

-- System and Performance
o.updatetime = 500 -- CursorHold delay
o.timeoutlen = 400 -- Mapping wait
o.ttimeoutlen = 0 -- Key code wait
o.undofile = true -- Persistent undo
o.swapfile = false -- No swap
o.writebackup = false -- No backup
o.shada = "'100,<50,s10,:1000,/100,@100,h" -- History limits
o.mouse = "" -- Disable mouse
o.maxmempattern = 20000 -- Regex memory
o.synmaxcol = 300 -- Syntax limit

later(function()
	vim.diagnostic.config({
		signs = { priority = 9999, severity = { min = "WARN", max = "ERROR" } },
		underline = { severity = { min = "HINT", max = "ERROR" } },
		virtual_lines = false,
		virtual_text = {
			current_line = true,
			severity = { min = "ERROR", max = "ERROR" },
		},
		float = {
			style = "minimal",
			source = true,
			header = "",
			prefix = "",
		},
		update_in_insert = false,
	})
end)

later(function()
	local server_list = {}
	local files = vim.api.nvim_get_runtime_file("after/lsp/*.lua", true)

	for _, c in ipairs(files) do
		table.insert(server_list, vim.fn.fnamemodify(c, ":t:r"))
	end

	vim.lsp.enable(server_list)
end)

-- Autocommands
autocmd("FileType", { "markdown", "text", "tex", "gitcommit", "vimwiki" }, function()
	ol.wrap = true
	ol.linebreak = true
	ol.breakindent = true
	ol.showbreak = ">> "
	ol.cpoptions:append("n")
end, { desc = "Prose wrapping" })

autocmd("LspAttach", "*", function(args)
	local client = vim.lsp.get_client_by_id(args.data.client_id)
	local bufnr = args.buf

	if not client then
		return
	end

	if client:supports_method("textDocument/completion") then
		vim.lsp.completion.enable(true, client.id, bufnr, {
			autotrigger = false,
			convert = function(item)
				local label = item.label
				if string.find(label, "(", 1, true) then
					label = label:gsub("%b()", "") -- Strip params from labels
				end
				return { abbr = label }
			end,
		})
	end
end, { desc = "Initialize LSP buffer" })

autocmd("OptionSet", "background", function()
	if vim.v.option_new ~= vim.v.option_old then
		vim.schedule(function()
			vim.cmd.colorscheme(vim.g.colors_name or "default")
		end)
	end
end, { desc = "Sync colorscheme" })

autocmd("FileType", "*", function()
	ol.formatoptions:remove("o") -- Prevent comment on 'o'
end, { desc = "Clean formatoptions" })

autocmd("TextYankPost", "*", function()
	vim.hl.on_yank()
end, { desc = "Yank highlight" })

usercmd("MergeConflicts", function()
	vim.schedule(function()
		local files = vim.fn.systemlist("git diff --name-only --diff-filter=U")
		if vim.v.shell_error ~= 0 then
			vim.notify("Not in a Git repository", 3)
			return
		end
		if #files == 0 then
			vim.notify("No conflicts!", 2)
			vim.cmd.cclose()
			return
		end
		local items = {}
		for _, file in ipairs(files) do
			table.insert(items, { filename = file, lnum = 1 })
		end
		vim.fn.setqflist({}, "r", { title = "Merge Conflicts", items = items })
		vim.cmd.copen()
	end)
end, { desc = "Conflicts to quickfix" })
