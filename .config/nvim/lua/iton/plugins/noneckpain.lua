return {
	"shortcuts/no-neck-pain.nvim",
	lazy = false,
	keys = { { "<leader>n", "<cmd>NoNeckPain<cr>" } },
	opts = {
		width = 90,
		autocmds = {
			enableOnVimEnter = true,
		},
	},
}
