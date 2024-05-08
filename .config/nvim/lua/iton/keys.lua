-- Holds all core keymaps
-- NOTE: Plugin-specific keymaps will be in their respective files

local M = require("iton.utils")
local map = M.map
local noremap_silent = M.noremap_silent
local silent = M.silent

local function set_mappings(mappings)
	---@diagnostic disable-next-line: deprecated
	local unpack = table.unpack or unpack
	for _, mapping in ipairs(mappings) do
		map(unpack(mapping))
	end
end

set_mappings({
	{ "n", "<leader>la", ":Lazy load all<cr>" },
	{ "n", "<leader>ll", ":Lazy<cr>", silent },
	{ "n", "<leader>lr", ":Lazy restore<cr>", silent },
})

set_mappings({
	{ "n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true } },
	{ "n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true } },
})

set_mappings({
	{ "n", "<C-f>", [[:%s/]], { desc = "Find and Replace" } },
	{ "v", "<C-f>", [[:s/]], { desc = "Find and Replace (Visual)" } },
	{ "n", "<M-f>", [[:cdo s/]], { desc = "Quickfix Find and Replace" } },
})

map("n", "<c-b>", "<Nop>", { desc = "None (to not conflict with wezterm)" })

map("v", "<C-S-c>", function()
	local original_reg = vim.fn.getreg('"')
	vim.cmd('normal! "+y')
	vim.fn.setreg('"', original_reg)
end, noremap_silent)

map("i", "jk", "<esc>", noremap_silent)

set_mappings({
	{ "n", "dp", vim.diagnostic.goto_prev, { desc = "Go to [D]iagnostic [P]revious message" } },
	{ "n", "dn", vim.diagnostic.goto_next, { desc = "Go to [D]iagnostic [N]ext message" } },
	{ "n", "do", vim.diagnostic.open_float, { desc = "[D]iagnostic [O]pen Float" } },
})

set_mappings({
	{ "n", "<c-u>", "<c-u>zz" },
	{ "n", "<c-d>", "<c-d>zz" },
})

map({ "n", "t" }, "<c-q>", function()
	if vim.bo.buftype == "terminal" then
		vim.cmd.startinsert()
		-- in case we in man page of diff
		-- will properly make showmode false
		vim.api.nvim_feedkeys("q", "t", true)
		vim.api.nvim_feedkeys("\n", "t", true)
		vim.api.nvim_feedkeys("exit", "t", true)
		vim.api.nvim_feedkeys("\n", "t", true)
		if vim.bo.filetype == "" then
			vim.schedule(function()
				vim.cmd("q")
			end)
		end
	else
		vim.cmd("q")
	end
end, silent)

set_mappings({
	{ "n", "<S-Up>", ":m .-2<CR>==", silent },
	{ "n", "<S-Down>", ":m .+1<CR>==", silent },
	{ "v", "<S-Up>", ":m '<-2<CR>gv=gv", silent },
	{ "v", "<S-Down>", ":m '>+1<CR>gv=gv", silent },
	{ "n", "<", "<<" },
	{ "n", ">", ">>" },
	{ "v", "<", "<gv" },
	{ "v", ">", ">gv" },
})

set_mappings({
	{ "n", "H", "_" },
	{ "n", "L", "$" },
})

map("n", "<CR>", function()
	if vim.opt.hlsearch:get() then
		vim.cmd.nohl()
		return ""
	else
		return vim.keycode("<CR>")
	end
end, { expr = true })

set_mappings({
	{ "n", "qn", ":cnext<CR>zz", noremap_silent },
	{ "n", "qp", ":cprev<CR>zz", noremap_silent },
	{ "n", "qo", ":botright copen<CR>", noremap_silent },
	{ "n", "qc", ":cclose<CR>", noremap_silent },
})

set_mappings({
	{ "n", "<C-h>", "<C-w><C-h>" },
	{ "n", "<C-l>", "<C-w><C-l>" },
	{ "n", "<C-j>", "<C-w><C-j>" },
	{ "n", "<C-k>", "<C-w><C-k>" },
})

map("t", "<esc><esc>", "<c-\\><c-n>")
map("n", "<c-t>", function()
	vim.cmd.new()
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 10)
	vim.wo.winfixheight = true
	vim.cmd.term()
	vim.cmd.startinsert()
end)

set_mappings({
	{ "n", "gu", "g~" },
	{ "n", "<M-c>", '<cmd>:echo ""<cr>', { desc = "Clear Command line" } },
})

map("n", "<M-t>", function()
	vim.o.background = vim.o.background == "dark" and "light" or "dark"
end)
