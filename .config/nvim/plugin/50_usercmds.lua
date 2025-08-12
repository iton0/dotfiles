local usercmd, later = vim.api.nvim_create_user_command, _G.MyConfig.later

later(function()
	usercmd("ToggleTheme", function()
		vim.o.background = (vim.o.background == "light") and "dark" or "light"

		local script = vim.fn.expand("~/.local/scripts/toggle-system-theme")

		if vim.fn.executable(script) == 1 then
			vim.system({ script }, {}, function(res)
				if res.code ~= 0 then
					vim.schedule(function()
						vim.notify("System theme script failed", vim.log.levels.ERROR)
					end)
				end
			end)
		else
			vim.notify("Theme sync script not found at " .. script, vim.log.levels.DEBUG)
		end
	end, { desc = "Toggle light/dark and sync system" })
end)

later(function()
	usercmd("MergeConflicts", function()
		vim.system({ "git", "diff", "--name-only", "--diff-filter=U" }, { text = true }, function(res)
			vim.schedule(function()
				if res.code ~= 0 then
					vim.notify("Not in a Git repository", vim.log.levels.WARN)
					return
				end

				local files = vim.split(res.stdout, "\n", { trimempty = true })

				if #files == 0 then
					vim.notify("No conflicts!", vim.log.levels.INFO)
					vim.cmd.cclose()
					return
				end

				local items = vim.iter(files):map(function(file)
					return { filename = file }
				end):totable()

				vim.fn.setqflist({}, " ", { title = "Merge Conflicts", items = items })
				vim.cmd.copen()
			end)
		end)
	end, { desc = "List git merge conflicts in quickfix" })
end)
