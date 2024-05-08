return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	cmd = "ConformInfo",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			["_"] = { "trim_whitespace" },
		},
		format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
		notify_on_error = false,
	},
}
