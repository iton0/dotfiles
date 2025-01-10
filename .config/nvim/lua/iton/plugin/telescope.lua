local M = require("iton.util")
local map = M.map
local home = M.home
return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},
	keys = {
		{ "<leader>" },
		{ "<c-p>" },
		{ "<c-g>" },
	},
	config = function()
		local telescope = require("telescope")
		telescope.setup({
			defaults = {
				preview = false,
				wrap_results = true,
				results_title = false,
				layout_config = {
					width = 0.90,
					height = 0.95,
				},
			},
			extensions = {
				wrap_results = true,
				fzf = {},
				["ui-select"] = {
					require("telescope.themes").get_cursor(),
				},
			},
		})
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")
		local builtin = require("telescope.builtin")
		map("n", "<leader>sh", builtin.help_tags, { desc = "Search Help" })
		map("n", "<leader>sk", builtin.keymaps, { desc = "Search Keymaps" })
		map("n", "<leader>sq", builtin.quickfix, { desc = "Search Quickfix" })
		map("n", "<leader><leader>", builtin.resume, { desc = "Opens the previous picker" })
		map("n", "<leader>ss", builtin.builtin, { desc = "Search Select Telescope" })
		map("n", "<leader>sg", builtin.live_grep, { desc = "Search by Grep" })
		map("n", "<c-p>", builtin.find_files, { desc = "Search Files" })
		map("n", "<c-g>", builtin.git_files, { desc = "Search Git Files" })
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
		end, { desc = "Search Dotfiles" })
		map("n", "<leader>mc", function()
			builtin.find_files({
				prompt_title = "Merge Conflicts",
				find_command = {
					"git",
					"diff",
					"--name-only",
					"--diff-filter=U",
				},
			})
		end, { desc = "Search Merge Conflicts" })
	end,
}
