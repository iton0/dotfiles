return {
	map = vim.keymap.set,
	silent = { silent = true },
	noremap_silent = { noremap = true, silent = true },
	noremap_silent_desc = function(desc)
		return { noremap = true, silent = true, desc = desc }
	end,

	home = os.getenv("HOME"),

	autocmd = vim.api.nvim_create_autocmd,

	signcol_size = ":5",

	is_plugin_loaded = function(plugin)
		-- NOTE: Uses plugin name rather than plugin module name
		-- ex) plugin = solarized.nvim vs. solarized
		if require("lazy.core.config").plugins[plugin]._.loaded == nil then
			return false
		else
			return true
		end
	end,
}
