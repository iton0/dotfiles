local wezterm = require("wezterm")
local act = wezterm.action
local M = {}

local home = os.getenv("HOME") .. "/"
local fd = home .. ".local/bin/fd"

M.open = function(window, pane)
	local projects = {}

	local success, stdout, stderr = wezterm.run_child_process({
		fd,
		"-HI",
		"-td",
		"--max-depth=2",
		".",
		home .. "Code/",
		-- add more paths here
	})

	if not success then
		wezterm.log_error("Failed to run fd: " .. stderr)
		return
	end

	-- fill table with results
	for line in stdout:gmatch("([^\n]*)\n?") do
		local project = line
		local label = project:gsub(home, "")
		local _, _, id = string.find(project, ".*/(.+)/")

		table.insert(projects, { label = tostring(label), id = tostring(id) })
	end

	wezterm.GLOBAL.previous_workspace = window:active_workspace()
	window:perform_action(
		act.InputSelector({
			action = wezterm.action_callback(function(win, _, id, label)
				if not id and not label then
					wezterm.log_info("Cancelled")
				else
					wezterm.log_info("Selected " .. label)
					win:perform_action(
						act.SwitchToWorkspace({
							name = label:match("([^/]+)$"):upper(),
							spawn = { cwd = home .. label },
						}),
						pane
					)
				end
			end),
			fuzzy = true,
			choices = projects,
		}),
		pane
	)
end

return M
