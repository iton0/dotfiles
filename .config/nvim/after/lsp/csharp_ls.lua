return {
	cmd = { "dotnet", "tool", "run", "csharp-ls" },
	root_dir = (function()
		local fname = vim.api.nvim_buf_get_name(0)
		if fname == "" then
			return vim.uv.cwd()
		end

		local root_file = vim.fs.find({ ".git", "global.json", ".sln", ".csproj" }, { path = fname, upward = true })[1]

		if root_file then
			return vim.fs.dirname(root_file)
		end

		return vim.uv.cwd()
	end)(),

	filetypes = { "cs" },

	init_options = {
		AutomaticWorkspaceInit = true,
	},

	get_language_id = function(_, ft)
		return ft == "cs" and "csharp" or ft
	end,
}
