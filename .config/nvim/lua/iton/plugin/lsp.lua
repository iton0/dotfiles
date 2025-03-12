return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPost", "BufNewFile" },
	cmd = "Mason",
	dependencies = {
		{ "williamboman/mason.nvim", config = true },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	build = ":MasonToolsUpdate",
	config = function()
		local single = "single"
		vim.diagnostic.config({
			float = {
				style = "minimal",
				source = true,
				header = "",
				prefix = "",
				border = single,
			},
		})
		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = single,
			title = false,
		})
		vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
			border = single,
			title = false,
		})
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end
				local builtin = require("telescope.builtin")
				map("gra", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
				map("grn", vim.lsp.buf.rename, "Rename Symbol")
				map("grr", vim.lsp.buf.references, "GoTo References")
				map("gri", vim.lsp.buf.implementation, "GoTo Implementation")
				map("gO", builtin.lsp_document_symbols, "Search Document Symbols")
				map("<leader>df", vim.diagnostic.setloclist, "Search File Diagnostics")
				map("<leader>dg", builtin.diagnostics, "Search Global Diagnostics")
				map("<c-s>", vim.lsp.buf.signature_help, "Signature Help")
			end,
		})
		local servers = {
			gopls = {},
			clangd = {
				settings = {
					clangd = {
						enableCodeCompletion = false,
						serverCompletionRanking = false,
					},
				},
			},
			lua_ls = {
				settings = { Lua = {
					diagnostics = { globals = { "vim" } },
				} },
			},
		}
		local ensure_installed = vim.tbl_keys(servers)
		vim.list_extend(ensure_installed, {
			"stylua",
		})
		require("mason-tool-installer").setup({
			ensure_installed = ensure_installed,
			auto_update = true,
		})
		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
