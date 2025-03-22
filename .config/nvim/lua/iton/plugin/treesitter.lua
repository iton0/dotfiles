return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	build = ":TSUpdateSync",
	main = "nvim-treesitter.configs",
	opts = {
		ensure_installed = {
			"c",
			"lua",
			"vim",
			"vimdoc",
			"query",
			"markdown",
			"markdown_inline",
			"go",
		},
		highlight = {
			enable = true,
			disable = function(_, buf)
				local max_filesize = 100 * 1024
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					return true
				end
			end,
		},
	},
}
