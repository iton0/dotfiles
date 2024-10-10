return {
	"neovim/nvim-lspconfig",
	event = "BufNewFile",
	cmd = "Mason",
	dependencies = {
		{ "williamboman/mason.nvim", config = true },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	build = ":MasonToolsUpdate",
	config = function()
		local _border = "single"

		vim.diagnostic.config({
			float = {
				focusable = false,
				style = "minimal",
				source = true,
				header = "",
				prefix = "",
				border = _border,
			},
		})

		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = _border,
			title = "HoverDocs",
		})
		vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
			border = _border,
			title = "SignatureDocs",
		})

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
				map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
				map("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
				map("gd", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
				map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
				map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("<leader>a", vim.lsp.buf.code_action, "Code [A]ction", { "n", "x" })
				map("gs", vim.lsp.buf.signature_help, "[S]ignature Documentation")
			end,
		})

		local servers = {
			gopls = {}, -- NOTE: need to install go binary
			clangd = {}, -- NOTE: need to install g++-12 package
			jdtls = { -- NOTE: need to install java package
				settings = {
					java = {
						configuration = {
							updateBuildConfiguration = "automatic",
						},
					},
				},
			},
			pyright = {},
			ts_ls = {},
			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						diagnostics = {
							disable = { "missing-fields" },
							globals = { "vim" },
						},
					},
				},
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
