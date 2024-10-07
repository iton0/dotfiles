return {
	"shortcuts/no-neck-pain.nvim",
	keys = { { "<leader>n", "<cmd>NoNeckPain<cr>" } },
	opts = {
		width = 90,
		autocmds = {
			skipEnteringNoNeckPainBuffer = true,
		},
	},
}
