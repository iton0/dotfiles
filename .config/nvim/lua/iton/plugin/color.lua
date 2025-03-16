return {
	"maxmx03/solarized.nvim",
	config = function()
		require("solarized").setup({
			palette = "selenized",
			on_highlights = function()
				local groups = {
					SignColumn = { bg = "NONE" },
					DiagnosticSignError = { bg = "NONE" },
					DiagnosticSignWarn = { bg = "NONE" },
					DiagnosticSignInfo = { bg = "NONE" },
					DiagnosticSignHint = { bg = "NONE" },
					DiagnosticSignOk = { bg = "NONE" },
					GitSignsAdd = { bg = "NONE" },
					GitSignsChange = { bg = "NONE" },
					GitSignsDelete = { bg = "NONE" },
					WinSeparator = { bg = "NONE" },
					LineNr = { bg = "NONE" },
				}
				return groups
			end,
			styles = { enabled = false },
		})
		vim.cmd.colorscheme("solarized")
	end,
}
