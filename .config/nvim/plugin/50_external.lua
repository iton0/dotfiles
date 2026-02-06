local plugins = {
	"https://github.com/nvim-mini/mini.nvim", -- mini.nvim library
	"https://codeberg.org/mfussenegger/nvim-lint", -- linter
}

local add_plugin = (vim.pack or MiniDeps).add
for _, plugin in ipairs(plugins) do
	add_plugin(plugin)
end

-- Configs

require("mini.extra").setup()

require("mini.surround").setup()

require("mini.diff").setup({
	mappings = {
		apply = "gha",
		reset = "ghr",
	},
})

require("mini.files").setup({ content = { prefix = function() end } })

local pick = require("mini.pick")
pick.setup({
	window = {
		config = function()
			local height = math.floor(0.618 * vim.o.lines)
			local width = math.floor(0.618 * vim.o.columns)
			return {
				anchor = "NW",
				height = height,
				width = width,
				row = math.floor(0.5 * (vim.o.lines - height)),
				col = math.floor(0.5 * (vim.o.columns - width)),
			}
		end,
	},
	source = {
		show = pick.default_show,
	},
})

require("lint").linters_by_ft = {
	go = { "golangcilint" },
	sh = { "shellcheck" },
	python = { "ruff" },
	elixir = { "credo" },
	c = { "cppcheck" },
	cpp = { "cppcheck" },
}
