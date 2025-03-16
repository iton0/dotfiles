local M = require("iton.util")
local map = M.map
local noremap_silent = M.noremap_silent
local silent = M.silent
local function set_mapping(mappings)
	---@diagnostic disable-next-line: deprecated
	local unpack = table.unpack or unpack
	for _, mapping in ipairs(mappings) do
		map(unpack(mapping))
	end
end
set_mapping({
	{ "n", "<leader>l", ":Lazy<cr>", silent },
	{ "n", "<leader>ch", ":Lazy load all<cr>:checkhealth<cr>/ERROR<cr>", silent },
})
set_mapping({
	{ "n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true } },
	{ "n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true } },
})
set_mapping({
	{ "n", "<C-f>", [[:%s/]], { desc = "Find and Replace" } },
	{ "v", "<C-f>", [[:s/]], { desc = "Find and Replace (Visual)" } },
	{ "x", "<C-f>", [[:s/]], { desc = "Find and Replace (Visual Block)" } },
	{ "n", "<M-f>", [[:cdo s/]], { desc = "Quickfix Find and Replace" } },
})
map("n", "<c-b>", "<Nop>", { desc = "None (to not conflict with tmux)" })
map("v", "<C-c>", function()
	local original_reg = vim.fn.getreg('"')
	vim.cmd('normal! "+y')
	vim.fn.setreg('"', original_reg)
end, noremap_silent)
map("i", "jk", "<esc>", noremap_silent)
map("n", "do", vim.diagnostic.open_float, { desc = "[D]iagnostic [O]pen" })
set_mapping({
	{ "n", "<c-u>", "<c-u>zz" },
	{ "n", "<c-d>", "<c-d>zz" },
})
map("n", "<c-q>", "<cmd>q<cr>", silent)
set_mapping({
	{ "n", "<S-Up>", ":m .-2<CR>==", silent },
	{ "n", "<S-Down>", ":m .+1<CR>==", silent },
	{ "v", "<S-Up>", ":m '<-2<CR>gv=gv", silent },
	{ "v", "<S-Down>", ":m '>+1<CR>gv=gv", silent },
	{ "n", "<", "<<" },
	{ "n", ">", ">>" },
	{ "v", "<", "<gv" },
	{ "v", ">", ">gv" },
})
set_mapping({
	{ "n", "H", "_" },
	{ "n", "L", "$" },
})
map("n", "<CR>", function()
	if vim.bo.filetype == "qf" then
		return vim.api.nvim_replace_termcodes("<CR>", true, false, true)
	elseif vim.opt.hlsearch:get() then
		vim.cmd.nohl()
		return ""
	else
		return vim.keycode("<CR>")
	end
end, { expr = true })
set_mapping({
	{ "n", "<M-j>", ":cnext<CR>zz", noremap_silent },
	{ "n", "<M-k>", ":cprev<CR>zz", noremap_silent },
	{ "n", "<leader>qo", ":copen<CR>", noremap_silent },
	{ "n", "<leader>qc", ":cclose<CR>", noremap_silent },
})
set_mapping({
	{ "n", "gu", "g~" },
	{ "n", "<M-c>", '<cmd>:echo ""<cr>', { desc = "Clear Command line" } },
})
