return {
	"stevearc/oil.nvim",
	keys = {
		{ "-", "<cmd>Oil<cr>" },
		{ "<leader>-", "<cmd>Oil --float<cr>" },
	},
	opts = {
		default_file_explorer = false,
		constrain_cursor = "name",
		win_options = {
			signcolumn = "yes" .. require("iton.util").signcol_size,
		},
		keymaps = {
			["<C-h>"] = false,
			["<C-l>"] = false,
			["<C-p>"] = false,
			["<C-t>"] = false,
		},
		view_options = {
			natural_order = false,
			show_hidden = true,
		},
	},
}
