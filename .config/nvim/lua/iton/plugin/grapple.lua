local M = require("iton.util")
local map = M.map
return {
	"cbochs/grapple.nvim",
	keys = {
		{ "m" },
	},
	config = function()
		local grapple = require("grapple")
		grapple.setup({
			scope = "git_branch",
			icons = false,
			status = false,
		})
		map("n", "m,", function()
			require("grapple").tag()
			print("Grapple Added")
			vim.defer_fn(function()
				vim.cmd('echo ""')
			end, 500)
		end)
		map("n", "mr", function()
			require("grapple").untag()
			print("Grapple Removed")
			vim.defer_fn(function()
				vim.cmd('echo ""')
			end, 500)
		end)
		map("n", "ml", function()
			require("grapple").toggle_tags()
		end)
		for idx, key in ipairs({ "a", "s", "d", "f", "g" }) do
			map("n", string.format("m%s", key), function()
				require("grapple").select({ index = idx })
			end)
		end
	end,
}
