local wezterm = require("wezterm")
local util = require("iton.utils")

wezterm.on("gui-startup", function(cmd)
	local args = {
		"sh",
		"-c",
		'echo "\n\\033[4mDotfiles Status\\033[0m" && '
			.. "/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME fetch && \n"
			.. "/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME status -sb && "
			.. 'echo "\nIf you pull run \\033[4m<leader>lr\\033[0m in Neovim" && '
			.. "exec $SHELL; ",
	}

	if cmd and cmd.args[1] == "ssh" then
		args = {
			"zsh",
		}
	end

	local _, _, window = wezterm.mux.spawn_window({
		args = args,
	})

	if cmd and cmd.args[1] == "ssh" then
		-- Maximize the window for SSH command
		window:gui_window():maximize()
	else
		-- Make fullscreen otherwise
		window:gui_window():toggle_fullscreen()
	end
	window:active_tab():set_title(util.default_tab_title)
end)

local function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use default tab title
	return util.default_tab_title
end

wezterm.on("format-tab-title", function(tab)
	local title = tab_title(tab)
	return {
		{ Text = " " .. (tab.tab_index + 1) .. ":" .. title .. "" },
	}
end)

wezterm.on("update-status", function(window, _, _)
	local date = wezterm.strftime("%I:%M %p ┃ %b %d %Y ")
	window:set_left_status(wezterm.format({
		{ Text = " " .. window:active_workspace() .. " " },
	}))
	window:set_right_status(wezterm.format({
		{ Text = date },
	}))
end)

wezterm.on("toggle-color-scheme", function(window, _)
	local overrides = window:get_config_overrides() or {}
	if overrides.color_scheme == util.light_scheme then
		overrides.color_scheme = util.dark_scheme
	else
		overrides.color_scheme = util.light_scheme
	end
	window:set_config_overrides(overrides)
end)
