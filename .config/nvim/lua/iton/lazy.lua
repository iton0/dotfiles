local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazyrepo,
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = "iton.plugin",
	dev = {
		path = "~/Code/neovim_dev/",
		fallback = true,
	},
	rocks = { enabled = false },
	change_detection = {
		notify = false,
	},
	ui = {
		icons = {
			cmd = " ",
			config = " ",
			event = " ",
			ft = " ",
			init = " ",
			import = " ",
			keys = " ",
			plugin = " ",
			lazy = " ",
			runtime = " ",
			require = " ",
			source = " ",
			start = " ",
		},
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"shada",
				"netrwPlugin",
				"tutor",
				"rplugin",
				"spellfile",
				"tohtml",
				"gzip",
				"tarPlugin",
				"zipPlugin",
			},
		},
	},
})
