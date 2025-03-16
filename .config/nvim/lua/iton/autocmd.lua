local autocmd = require("iton.util").autocmd
autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt.formatoptions:remove("o")
	end,
})
autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
