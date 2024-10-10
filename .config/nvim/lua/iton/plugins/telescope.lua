local M = require("iton.utils")
local map = M.map
local home = M.home

return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
	},
	keys = {
		{ "<leader>" },
	},
	config = function()
		local telescope = require("telescope")

		telescope.setup({
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		local builtin = require("telescope.builtin")

		map("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		map("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
		map("n", "<leader>sq", builtin.quickfix, { desc = "[S]earch [Q]uickfix" })
		map("n", "<leader><leader>", builtin.resume, { desc = "Opens the previous picker" })
		map("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
		map("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		map("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
		map("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
		map("n", "<leader>gg", builtin.git_files, { desc = "[G]et [G]it files" })
		map("n", "<leader>s.", function()
			builtin.find_files({
				cwd = home,
				prompt_title = "Dotfiles",
				find_command = {
					"git",
					"--git-dir=.dotfiles",
					"ls-tree",
					"-r",
					"HEAD",
					"--name-only",
				},
			})
		end, { desc = "[S]earch [.](Dot)files" })
	end,
}
