local create_usercmd = vim.api.nvim_create_user_command

create_usercmd("MergeConflicts", function()
	local files = vim.fn.systemlist("git diff --name-only --diff-filter=U")
	if vim.v.shell_error ~= 0 then
		vim.notify("Not in a Git repository", vim.log.levels.ERROR)
		return
	end
	if #files == 0 then
		vim.notify("No conflicts!", vim.log.levels.INFO)
		vim.cmd.cclose()
		return
	end
	local items = {}
	for _, file in ipairs(files) do
		table.insert(items, { filename = file, lnum = 1 })
	end
	vim.fn.setqflist({}, "r", { title = "Merge Conflicts", items = items })
	vim.cmd.copen()
end, { desc = "Conflicts to quickfix" })
