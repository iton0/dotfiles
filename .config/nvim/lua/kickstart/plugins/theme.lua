return {
	-- Theme inspired by TokyoNight
	'folke/tokyonight.nvim',
	lazy = true,
	event = { 'BufReadPre', 'BufNewFile' },
	priority = 1000,
	config = function()
		vim.cmd([[colorscheme tokyonight-storm]])
		-- Adjust Neovim visual elements
		vim.cmd([[highlight CursorLineNr ctermfg=Yellow guifg=#FFD700]])
		vim.cmd([[highlight LineNr ctermfg=LightGray guifg=LightGray]])
		vim.cmd([[highlight CursorLine guibg=NONE ctermbg=NONE]])
		vim.cmd([[highlight Normal guibg=NONE ctermbg=NONE]])
		vim.cmd [[highlight LspDiagnosticsDefault guibg=NONE ctermbg=NONE]]
		vim.cmd [[highlight SignColumn guibg=NONE ctermbg=NONE]]
		vim.cmd [[highlight NonText guibg=NONE ctermbg=NONE]]
		vim.cmd [[highlight NormalNC guibg=NONE ctermbg=NONE]]
		vim.cmd [[highlight VertSplit guibg=NONE ctermbg=NONE]]
	end,
}
