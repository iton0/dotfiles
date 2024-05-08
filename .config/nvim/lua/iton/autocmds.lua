local autocmd = require("iton.utils").autocmd

autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt.formatoptions:remove({ "o" })
	end,
})

autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

autocmd("TermOpen", {
	callback = function()
		vim.opt_local.showmode = true
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.scrolloff = 0
	end,
})

autocmd("TermClose", {
	callback = function()
		vim.opt_local.showmode = false
	end,
})
