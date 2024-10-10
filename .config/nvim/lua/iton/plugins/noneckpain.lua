return {
	"shortcuts/no-neck-pain.nvim",
	lazy = false,
	keys = { { "<leader>n", "<cmd>NoNeckPain<cr>" } },
	opts = {
		width = 95,
		autocmds = {
			enableOnVimEnter = true,
		},
	},
}
