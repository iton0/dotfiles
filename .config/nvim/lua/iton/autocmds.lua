local autocmd = require("iton.utils").autocmd

-- Define a simple monad structure for managing loaded states
local PluginMonad = {}
PluginMonad.__index = PluginMonad

function PluginMonad:new(loaded_states)
	return setmetatable({ loaded_states = loaded_states or {} }, self)
end

function PluginMonad:load(plugins)
	local key = table.concat(plugins, ",")
	if not self.loaded_states[key] and vim.bo.filetype ~= "oil" then
		require("lazy").load({ plugins = plugins })
		self.loaded_states[key] = true
	end
	return self -- Return self to allow chaining
end

function PluginMonad:mark_loaded(plugins)
	local key = table.concat(plugins, ",")
	self.loaded_states[key] = true
	return self -- Return self to allow chaining
end

-- Create an instance of the monad
local plugin_monad = PluginMonad:new()

local bufpre_plugins = {
	"nvim-lspconfig",
	"guess-indent.nvim",
	-- Add more plugins here
}

local bufpost_plugins = {
	"nvim-treesitter",
	"gitsigns.nvim",
	-- Add more plugins here
}

-- Lazy load specific plugins based on file types or conditions
local function lazy_load(condition_plugins)
	return function()
		plugin_monad:load(condition_plugins)
	end
end

-- Autocommands
autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt.formatoptions:remove({ "o" })
	end,
})

autocmd("FileType", {
	pattern = "mason",
	callback = function()
		if not plugin_monad.loaded_states[bufpre_plugins[1]] then
			plugin_monad:mark_loaded({ bufpre_plugins[1] })
		end
	end,
})

autocmd("FileType", {
	pattern = "TelescopePrompt",
	callback = function()
		if not plugin_monad.loaded_states[bufpost_plugins[1]] then
			plugin_monad:mark_loaded({ bufpost_plugins[1] })
		end
	end,
})

autocmd("BufReadPre", {
	callback = lazy_load(bufpre_plugins), -- Load pre-buffer plugins lazily
})

autocmd("BufReadPost", {
	callback = lazy_load(bufpost_plugins), -- Load post-buffer plugins lazily
})

autocmd("BufNewFile", {
	callback = function()
		plugin_monad
			:load({ bufpre_plugins[2] }) -- Load second pre buffer plugin
			:load({ bufpost_plugins[1] }) -- Load first post buffer plugin
			:mark_loaded({ bufpre_plugins[1] }) -- Mark first pre buffer plugin as loaded
	end,
})

autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

autocmd("TermOpen", {
	callback = function()
		vim.opt_local.showmode = true
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.scrolloff = 0
	end,
})

autocmd("TermClose", {
	callback = function()
		vim.opt_local.showmode = false
	end,
})
