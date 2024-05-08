return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	main = "nvim-treesitter.configs",
	opts = {
		ensure_installed = {
			"bash",
			"c",
			"diff",
			"html",
			"query",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"vim",
			"vimdoc",
		},
		auto_install = true,
		highlight = { enable = true },
		indent = { enable = true },
	},
}
