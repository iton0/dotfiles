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
