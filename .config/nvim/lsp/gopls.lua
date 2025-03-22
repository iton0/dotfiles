return {
	cmd = { "gopls" },
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
			staticcheck = true,
			gofumpt = true,
			semanticTokens = true,
		},
	},
	filetypes = { "go", "gomod", "gosum" },
	root_markers = {
		"go.mod",
		"go.sum",
	},
	on_attach = function()
		vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>")
	end,
}
