return {
	"williamboman/mason.nvim",
	event = { "BufReadPre", "BufNewFile" },
	cmd = "Mason",
	dependencies = "WhoIsSethDaniel/mason-tool-installer.nvim",
	build = ":MasonToolsUpdateSync",
	config = function()
		require("mason").setup()
		local servers = {
			"gopls",
			"clangd",
			"lua-language-server",
		}
		require("mason-tool-installer").setup({
			ensure_installed = vim.list_extend(servers, {
				-- NOTE: formatters and such can go here
			}),
		})
		vim.diagnostic.config({
			virtual_text = true,
			float = {
				style = "minimal",
				source = true,
				header = "",
				prefix = "",
			},
		})
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end
				local builtin = require("telescope.builtin")
				map("gO", builtin.lsp_document_symbols, "Search Document Symbols")
				map("<leader>ss", builtin.lsp_dynamic_workspace_symbols, "Search Workspace Symbols")
				map("<leader>dg", builtin.diagnostics, "Search Global Diagnostics")
				map("<leader>df", vim.diagnostic.setloclist, "Search File Diagnostics")
				map("do", vim.diagnostic.open_float, "Diagnostic Open")
			end,
		})
		vim.lsp.enable(servers)
	end,
}
