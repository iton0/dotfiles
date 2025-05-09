local function switch_source_header(bufnr)
	local method_name = "textDocument/switchSourceHeader"
	local client = vim.lsp.get_clients({ bufnr = bufnr, name = "clangd" })[1]
	if not client then
		return vim.notify(
			("method %s is not supported by any servers active on the current buffer"):format(method_name)
		)
	end
	local params = vim.lsp.util.make_text_document_params(bufnr)
	client.request(method_name, params, function(err, result)
		if err then
			error(tostring(err))
		end
		if not result then
			vim.notify("corresponding file cannot be determined")
			return
		end
		vim.cmd.edit(vim.uri_to_fname(result))
	end, bufnr)
end
return {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--header-insertion=iwyu",
		"--completion-style=detailed",
		"--function-arg-placeholders",
		"--fallback-style=llvm",
	},
	init_options = {
		usePlaceholders = true,
		completeUnimported = true,
		clangdFileStatus = true,
	},
	filetypes = {
		"c",
		"cpp",
	},
	root_markers = { "compile_commands.json", ".clang" },
	on_attach = function()
		vim.api.nvim_buf_create_user_command(0, "LspClangdSwitchSourceHeader", function()
			switch_source_header(0)
		end, { desc = "Switch between source/header" })

		-- Both C/C++ logic
		vim.keymap.set("n", "<leader>cs", "<cmd>LspClangdSwitchSourceHeader<cr>")
		if vim.bo.filetype == "c" then -- C logic
			return
		else                     -- C++ logic
			return
		end
	end,
}
