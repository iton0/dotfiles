local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	spec = "iton.plugin",
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
