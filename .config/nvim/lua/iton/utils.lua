return {
	map = vim.keymap.set,
	silent = { silent = true },
	noremap_silent = { noremap = true, silent = true },
	noremap_silent_desc = function(desc)
		return { noremap = true, silent = true, desc = desc }
	end,

	home = os.getenv("HOME"),

	autocmd = vim.api.nvim_create_autocmd,

	is_loaded = function(plugin)
		-- check if plugin is not loaded
		-- NOTE: Use plugin name not plugin module name
		-- ex) plugin = solarized.nvim vs. solarized
		if require("lazy.core.config").plugins[plugin]._.loaded == nil then
			return false
		else
			return true
		end
	end,
}
