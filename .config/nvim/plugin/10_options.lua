local g, o                 = vim.g, vim.o
local now, later, autocmd  = _G.MyConfig.now, _G.MyConfig.later, _G.MyConfig.new_autocmd

g.mapleader                = " "
g.maplocalleader           = " "
g.loaded_tutor_mode_plugin = 1
g.loaded_netrwPlugin       = 1
g.loaded_netrw             = 1
g.loaded_python3_provider  = 0
g.loaded_python_provider   = 0
g.loaded_node_provider     = 0
g.loaded_perl_provider     = 0
g.loaded_ruby_provider     = 0

o.background               = "light"
o.diffopt                  = "internal,filler,closeoff,linematch:60"
o.completeopt              = "fuzzy,menuone,noinsert,popup"
o.shada                    = "'100,<50,s10,:1000,/100,@100,h"
o.virtualedit              = "block"
o.fillchars                = "eob: "
o.wildmode                 = "longest:full,full"
o.winborder                = "single"
o.inccommand               = "split"
o.splitkeep                = "screen"
o.signcolumn               = "yes:5"
o.mouse                    = ""
o.maxmempattern            = 20000
o.pumheight                = 10
o.timeoutlen               = 500
o.synmaxcol                = 300
o.textwidth                = 80
o.sidescrolloff            = 10
o.scrolloff                = 10
o.softtabstop              = 4
o.shiftwidth               = 4
o.tabstop                  = 4
o.helpheight               = 0
o.ttimeoutlen              = 0
o.smoothscroll             = true
o.smartindent              = true
o.autoindent               = true
o.ignorecase               = true
o.splitbelow               = true
o.splitright               = true
o.smartcase                = true
o.undofile                 = true
o.writebackup              = false
o.showmode                 = false
o.swapfile                 = false
o.wrap                     = false

now(function()
	vim.cmd.colorscheme("helium")
end)

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
	autocmd("LspAttach", "*", function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local bufnr = args.buf

		if not client then return end

		client.server_capabilities.semanticTokensProvider = nil

		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, bufnr, {
				autotrigger = false,
				convert = function(item)
					return { abbr = item.label:gsub("%b()", "") }
				end,
			})
		end
	end, { desc = "Attach lsp to buffer" }
	)

	local config_files = vim.api.nvim_get_runtime_file("after/lsp/*.lua", true)
	vim.lsp.enable(vim.iter(config_files)
		:map(function(file)
			return vim.fn.fnamemodify(file, ":t:r")
		end)
		:totable())
end)
