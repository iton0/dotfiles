return {
	-- Theme inspired by TokyoNight
	'folke/tokyonight.nvim',
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd([[colorscheme tokyonight-storm]])
	end,
}
