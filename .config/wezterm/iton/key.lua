local wezterm = require("wezterm")
local act = wezterm.action
local util = require("iton.util")
local M = {}

M.apply = function(config)
	config.disable_default_key_bindings = true
	config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 400 }
	config.keys = {
		{
			mods = "CTRL|SHIFT",
			key = "P",
			action = act.ActivateCommandPalette,
		},
		{
			mods = "CTRL|SHIFT",
			key = "L",
			action = act.ShowDebugOverlay,
		},
		{
			mods = "CTRL|SHIFT",
			key = "X",
			action = act.ActivateCopyMode,
		},
		{
			mods = "CTRL|SHIFT",
			key = "V",
			action = act.PasteFrom("Clipboard"),
		},
		{
			mods = "ALT",
			key = "Enter",
			action = act.ToggleFullScreen,
		},
		{
			mods = "CTRL",
			key = "=",
			action = act.IncreaseFontSize,
		},
		{
			mods = "CTRL",
			key = "-",
			action = act.DecreaseFontSize,
		},
		{
			mods = "CTRL",
			key = "0",
			action = act.ResetFontSize,
		},
		{
			mods = "LEADER",
			key = "c",
			action = wezterm.action_callback(function(window, pane)
				window:perform_action(wezterm.action.SpawnTab("CurrentPaneDomain"), pane)
				window:active_tab():set_title(util.default_tab_title)
			end),
		},
		{
			mods = "LEADER",
			key = "x",
			action = wezterm.action_callback(function(window, pane)
				local tabs = window:mux_window():tabs()

				if #tabs == 1 then
					window:perform_action(
						act.CloseCurrentTab({
							confirm = true,
						}),
						pane
					)
					wezterm.GLOBAL.previous_workspace = nil
				else
					window:perform_action(
						act.CloseCurrentTab({
							confirm = true,
						}),
						pane
					)
				end
			end),
		},
		{
			mods = "ALT|SHIFT",
			key = "L",
			action = act.ActivateTabRelativeNoWrap(1),
		},
		{
			mods = "ALT|SHIFT",
			key = "H",
			action = act.ActivateTabRelativeNoWrap(-1),
		},
		{
			mods = "LEADER",
			key = "r",
			action = act.PromptInputLine({
				description = "Enter new tab name",
				action = wezterm.action_callback(function(window, _, line)
					if line == "" then
						window:active_tab():set_title(util.default_tab_title)
					else
						window:active_tab():set_title(line .. " ")
					end
				end),
			}),
		},
		{
			mods = "LEADER",
			key = "f",
			action = wezterm.action_callback(require("iton.sessionizer").open),
		},
		{
			mods = "LEADER",
			key = "h",
			action = wezterm.action_callback(function(window, pane)
				local current_workspace = window:active_workspace()

				if current_workspace == "HOME" then
					return
				end

				wezterm.GLOBAL.previous_workspace = current_workspace
				window:perform_action(
					act.SwitchToWorkspace({
						name = "HOME",
					}),
					pane
				)
			end),
		},
		{
			mods = "LEADER",
			key = "p",
			action = wezterm.action_callback(function(window, pane)
				local current_workspace = window:active_workspace()
				local workspace = wezterm.GLOBAL.previous_workspace

				if current_workspace == workspace or wezterm.GLOBAL.previous_workspace == nil then
					return
				end

				window:perform_action(
					act.SwitchToWorkspace({
						name = workspace,
					}),
					pane
				)
				wezterm.GLOBAL.previous_workspace = current_workspace
			end),
		},
		{
			mods = "LEADER",
			key = "s",
			action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
		},
		{
			mods = "ALT",
			key = "t",
			action = act.EmitEvent("toggle-color-scheme"),
		},
	}
end

return M
