local usercmd = vim.api.nvim_create_user_command

usercmd("MergeConflicts", function()
        -- Asynchronous Git command invocation
        vim.system({ "git", "ls-files", "-u" }, { text = true }, function(obj)
                if obj.code ~= 0 then
                        vim.schedule(function()
                                vim.notify("Git error: Not in a repository", vim.log.levels.ERROR)
                        end)
                        return
                end

                local items = {}
                local seen = {} -- Track unique files efficiently in a single loop

                -- Guard against empty stdout safely
                local stdout = obj.stdout or ""

                for line in stdout:gmatch("[^\r\n]+") do
                        -- Safely extract the 4th column (filepath) ignoring git metadata columns
                        local path = line:match("^%d+%s+%x+%s+%d+%s+(.+)$")

                        if path and not seen[path] then
                                seen[path] = true
                                table.insert(items, {
                                        filename = path,
                                        lnum = 1,
                                        text = "CONFLICT (unmerged)",
                                })
                        end
                end

                -- Safe UI interaction transition via the main thread schedule loop
                vim.schedule(function()
                        if #items == 0 then
                                vim.notify("No conflicts found", vim.log.levels.INFO)
                                vim.cmd.cclose()
                                return
                        end

                        vim.fn.setqflist({}, "r", { title = "Merge/Rebase Conflicts", items = items })
                        vim.cmd.copen()
                        vim.notify("Found " .. #items .. " conflicts", vim.log.levels.WARN)
                end)
        end)
end, { desc = "Merge/Rebase conflicts to quickfix" })
