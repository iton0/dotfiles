local create_usercommand = vim.api.nvim_create_user_command

create_usercommand("MergeConflicts", function()
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
end, { desc = "Merge conflicts to quickfix" })

create_usercommand("LspRestart", function()
	local clients = vim.lsp.get_clients()
	if #clients > 0 then
		vim.lsp.stop_client(clients)
		vim.schedule(function()
			vim.cmd.edit()
			vim.notify("LSP clients stopped; reloading buffer to restart...", vim.log.levels.INFO)
		end)
	else
		vim.notify("No active LSP clients found", vim.log.levels.WARN)
	end
end, { desc = "Restart all active LSP client(s)" })

create_usercommand("LspStop", function()
	local clients = vim.lsp.get_clients()
	if #clients > 0 then
		vim.lsp.stop_client(clients)
		vim.schedule(function()
			vim.notify("LSP clients stopped", vim.log.levels.INFO)
		end)
	else
		vim.notify("No active LSP clients found", vim.log.levels.WARN)
	end
end, { desc = "Stop all active LSP client(s)" })
