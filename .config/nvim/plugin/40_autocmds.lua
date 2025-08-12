local autocmd, later = _G.MyConfig.new_autocmd, _G.MyConfig.later

later(function()
	local function get_system_theme()
		local default = "light"

		if vim.fn.executable("dbus-send") == 0 then return default end

		local success, obj = pcall(function()
			return vim.system({
				"dbus-send", "--session", "--print-reply=literal",
				"--dest=org.freedesktop.portal.Desktop",
				"/org/freedesktop/portal/desktop",
				"org.freedesktop.portal.Settings.Read",
				"string:org.freedesktop.appearance", "string:color-scheme"
			}, { text = true }):wait()
		end)

		if success and obj and obj.code == 0 and obj.stdout then
			if obj.stdout:find("uint32 1") then
				return "dark"
			end
		end

		return default
	end

	autocmd("FocusGained", "*", function()
		if vim.api.nvim_get_mode().mode == "n" then
			vim.cmd.checktime()
		end

		local appearance = get_system_theme()
		if appearance ~= vim.o.background then
			vim.o.background = appearance
		end
	end, { desc = "Sync file changes and system theme on focus" })
end)

later(function()
	autocmd("OptionSet", "background", function()
		if vim.v.option_new ~= vim.v.option_old then
			vim.cmd.colorscheme(vim.g.colors_name or "default")
		end
	end, { desc = "Reload theme on background change" })
end)

later(function()
	autocmd("FileType", "*", function()
		vim.opt_local.formatoptions:remove("o")
	end, { desc = "Disable auto-comment on new line" })
end)

later(function()
	autocmd("TextYankPost", "*", function()
		vim.hl.on_yank()
	end, { desc = "Highlight yanked text" })
end)
