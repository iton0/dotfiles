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
		vim.keymap.set("n", "<M-t>", function()
				local out_str = vim.fn.system("~/.local/scripts/toggle-system-theme")
				local cleaned_out_str = string.gsub(out_str, "[^01]", "")
				local out = tonumber(cleaned_out_str)
				if out == 0 then
					vim.o.background = "light"
				elseif out == 1 then
					vim.o.background = "dark"
				else
					vim.api.nvim_echo({
						{ "Unexpected output from theme script:\n", "ErrorMsg" },
						{ out_str,                                  "WarningMsg" },
						{ "\nPress any key to exit..." },
					}, true, {})
					vim.fn.getchar()
					os.exit(1)
				end
			end,
			{ noremap = true, silent = true })
	end,
}
