local autocmd = require("iton.util").autocmd
autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt.formatoptions:remove("o")
	end,
})
autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})
