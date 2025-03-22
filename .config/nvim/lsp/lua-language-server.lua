return {
	cmd = { "lua-language-server" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			telemetry = {
				enable = false,
			},
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
	filetypes = { "lua" },
	root_markers = { ".luarc.json", "luarc.lua", ".git" },
}
