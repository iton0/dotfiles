return {
	"maxmx03/solarized.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("solarized").setup({
			palette = "selenized",
			on_highlights = function()
				local groups = {
					SignColumn = { bg = "NONE" },
					LineNr = { bg = "NONE" },
					WinSeparator = { bg = "NONE" },
					DiagnosticSignError = { bg = "NONE" },
					DiagnosticSignHint = { bg = "NONE" },
					DiagnosticSignWarn = { bg = "NONE" },
					DiagnosticSignInfo = { bg = "NONE" },
					DiagnosticSignOk = { bg = "NONE" },
					GitSignsAdd = { bg = "NONE" },
					GitSignsChange = { bg = "NONE" },
					GitSignsDelete = { bg = "NONE" },
				}
				return groups
			end,
			styles = { enabled = false },
		})
		vim.cmd.colorscheme("solarized")
	end,
}
