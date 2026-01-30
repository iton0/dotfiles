-- local add, build = vim.pack.add, _G.MyConfig.on_packchanged
local now, now_if_args, later, autocmd =
	_G.MyConfig.now, _G.MyConfig.now_if_args, _G.MyConfig.later, _G.MyConfig.new_autocmd

-- TODO: Switch to vim.pack.add when 0.12.x lands
-- remove below code block and uncomment the first line in this file
now(function()
	require("mini.deps").setup()
end)
local add = MiniDeps.add

-- Core Mini.nvim modules
now_if_args(function()
	add("https://github.com/nvim-mini/mini.nvim")
end)

now_if_args(function()
	require("mini.files").setup({ content = { prefix = function() end } })
end)

later(function()
	local pick = require("mini.pick")
	pick.setup({
		window = {
			config = function()
				local height = math.floor(0.618 * vim.o.lines) -- Golden ratio height
				local width = math.floor(0.618 * vim.o.columns) -- Golden ratio width
				return {
					anchor = "NW",
					height = height,
					width = width,
					row = math.floor(0.5 * (vim.o.lines - height)),
					col = math.floor(0.5 * (vim.o.columns - width)),
				}
			end,
		},
		source = { show = pick.default_show },
	})
end)

-- Linting
later(function()
	add("https://codeberg.org/mfussenegger/nvim-lint")
	local lint = require("lint")

	lint.linters_by_ft = {
		go = { "golangcilint" },
		sh = { "shellcheck" },
		python = { "ruff" },
		elixir = { "credo" },
	}

	autocmd("BufWritePost", "*", function()
		lint.try_lint()
	end, { desc = "Trigger linting" })
end)
