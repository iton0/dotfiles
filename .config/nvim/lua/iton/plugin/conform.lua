return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	cmd = "ConformInfo",
	opts = {
		formatters_by_ft = {
			["_"] = { "trim_whitespace", lsp_format = "prefer" },
		},
		default_format_opts = { lsp_format = "fallback" },
		format_on_save = { timeout_ms = 500 },
		notify_on_error = false,
	},
}
