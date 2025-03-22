return {
	map = vim.keymap.set,
	silent = { silent = true },
	noremap_silent = { noremap = true, silent = true },
	noremap_silent_desc = function(desc)
		return { noremap = true, silent = true, desc = desc }
	end,
	home = os.getenv("HOME"),
	autocmd = vim.api.nvim_create_autocmd,
	signcol_size = "yes:5",
	set_bg = function()
		local EXPECTED_VALUE = "Adwaita-dark"
		local handle = io.popen("gsettings get org.gnome.desktop.interface gtk-theme")
		local LAST_LINE = handle:read("*a")
		handle:close()

		-- Remove surrounding quotes and any trailing newline
		LAST_LINE = string.gsub(LAST_LINE, "'", "")
		LAST_LINE = string.gsub(LAST_LINE, "%s+$", "")

		if LAST_LINE == EXPECTED_VALUE then
			return "dark"
		else
			return "light"
		end
	end
}
