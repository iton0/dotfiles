return {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gosum", "gotmpl" },
	root_dir = function(buf, cb)
		local path = vim.api.nvim_buf_get_name(buf)
		if path == "" then
			return
		end
		local cwd = vim.fs.dirname(path)

		local ok = pcall(vim.system, { "go", "env", "-json", "GOMOD" }, { cwd = cwd }, function(out)
			if out.code == 0 then
				local decode_ok, data = pcall(vim.json.decode, out.stdout)
				if decode_ok and data.GOMOD and data.GOMOD ~= "/dev/null" and data.GOMOD ~= "" then
					cb(vim.fs.dirname(data.GOMOD))
				end
			end
		end)

		if not ok then
			local root = vim.fs.root(buf, { "go.mod" })
			if root then
				local workspace = vim.fs.root(root, { "go.work" })
				cb(workspace or root)
			end
		end
	end,
}
