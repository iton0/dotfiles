local map_set = vim.keymap.set
local function map_toggle_set(char, expr, desc)
	map_set("n", "yo" .. char, expr, { desc = "[Y]ield [O]ption " .. desc })
end

map_toggle_set("h", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, "Hints")
map_toggle_set("q", function()
	local qf_win = vim.fn.getqflist({ winid = 0 }).winid
	vim.cmd(qf_win ~= 0 and "cclose" or "copen")
end, "Quickfix")
map_toggle_set("l", function()
	local loc_win = vim.fn.getloclist(0, { winid = 0 }).winid
	vim.cmd(loc_win ~= 0 and "lclose" or "lopen")
end, "Loclist")
map_toggle_set("d", function()
	require("mini.diff").toggle_overlay(0)
end, "Diff Overlay")

map_set({ "n", "x" }, "gy", '"+y', { desc = "Copy to system" })
map_set("n", "gp", '"+p', { desc = "Paste from system" })
map_set("x", "gp", '"+P', { desc = "Paste from system (No register overwrite)" })

map_set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map_set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
map_set("x", "<", "<gv")
map_set("x", ">", ">gv")
map_set("n", "<BS>", "<cmd>nohlsearch<cr>")

map_set("n", "<C-d>", "<C-d>zz")
map_set("n", "<C-u>", "<C-u>zz")
map_set("n", "n", "nzzzv")
map_set("n", "N", "Nzzzv")

for target_tab, key in ipairs({
	"h",
	"j",
	"k",
	"l",
	";",
}) do
	map_set("n", "gt" .. key, target_tab .. "gt", {
		desc = "Jump to Tab " .. target_tab,
	})
end

for key, dir in pairs({ h = "left", j = "bottom", k = "top", l = "right" }) do
	map_set("n", "<C-" .. key .. ">", "<C-w>" .. key, { desc = "Focus " .. dir })
	map_set("t", "<C-" .. key .. ">", [[<C-\><C-n><C-w>]] .. key)
end
map_set("t", "<Esc><Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
map_set("n", "<C-space>", "<Nop>")

map_set("i", "<CR>", function()
	if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info()["selected"] ~= -1 then
		return "<C-y>"
	end
	return "<CR>"
end, { expr = true })
map_set("n", "<leader>d", function()
	vim.diagnostic.setqflist()
end, { desc = "Project Diagnostics -> Quickfix" })

map_set("n", "-", function()
	MiniFiles.open(vim.api.nvim_buf_get_name(0))
end, { desc = "Explorer (mini.files)" })
map_set("n", "<leader>f", function()
	MiniPick.builtin.files()
end)
map_set("n", "<leader>g", function()
	MiniExtra.pickers.git_files()
end)
map_set("n", "<leader>/", function()
	MiniPick.builtin.grep_live()
end)
