local uv = vim.uv
local fs = vim.fs

local group = vim.api.nvim_create_augroup("lspconfig.roslyn_ls", { clear = true })

local roslyn_binary =
	vim.fn.expand("~/.local/share/nvim/roslyn/content/LanguageServer/linux-x64/Microsoft.CodeAnalysis.LanguageServer")

---@param client vim.lsp.Client
---@param target string
local function on_init_sln(client, target)
	vim.notify("Initializing: " .. target, vim.log.levels.INFO, { title = "roslyn_ls" })
	client:notify("solution/open", {
		solution = vim.uri_from_fname(target),
	})
end

---@param client vim.lsp.Client
---@param project_files string[]
local function on_init_project(client, project_files)
	vim.notify("Initializing: projects", vim.log.levels.INFO, { title = "roslyn_ls" })
	client:notify("project/open", {
		projects = vim.tbl_map(function(file)
			return vim.uri_from_fname(file)
		end, project_files),
	})
end

local function roslyn_handlers()
	return {
		["workspace/projectInitializationComplete"] = function(_, _, ctx)
			vim.notify("Roslyn project initialization complete", vim.log.levels.INFO, { title = "roslyn_ls" })
			return vim.NIL
		end,
		["workspace/_roslyn_projectNeedsRestore"] = function(_, result, ctx)
			local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
			client:request("workspace/_roslyn_restore", result, function(err, response)
				if err then
					vim.notify(err.message or "Restore failed", vim.log.levels.ERROR, { title = "roslyn_ls" })
				end
			end)
			return vim.NIL
		end,
	}
end

return {
	name = "roslyn_ls",
	cmd = {
		roslyn_binary,
		"--logLevel",
		"Information",
		"--extensionLogDirectory",
		fs.joinpath(uv.os_tmpdir(), "roslyn_ls/logs"),
		"--stdio",
	},
	filetypes = { "cs" },
	handlers = roslyn_handlers(),
	on_init = function(client)
		-- SAFETY: Fallback to current working directory if root_dir isn't set
		local root_dir = client.config.root_dir or vim.fn.getcwd()

		-- 1. Try to find solution files
		local sln_match = fs.find(function(name)
			return name:match("%.sln[x]?$")
		end, { path = root_dir, upward = false })

		if #sln_match > 0 then
			-- sln_match[1] is already an absolute path from fs.find
			on_init_sln(client, sln_match[1])
			return
		end

		-- 2. Fallback: Try to find project files
		local csproj_match = fs.find(function(name)
			return name:match("%.csproj$")
		end, { path = root_dir, upward = false })

		if #csproj_match > 0 then
			on_init_project(client, { csproj_match[1] })
		end
	end,
	capabilities = {
		textDocument = {
			diagnostic = { dynamicRegistration = true },
		},
	},
	settings = {
		["csharp|background_analysis"] = {
			dotnet_analyzer_diagnostics_scope = "fullSolution",
			dotnet_compiler_diagnostics_scope = "fullSolution",
		},
	},
}
