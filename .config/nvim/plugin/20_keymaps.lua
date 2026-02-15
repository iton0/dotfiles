local keymap_set = vim.keymap.set
local function keymap_toggle_set(char, expr, desc)
	keymap_set("n", "yo" .. char, expr, { desc = "[Y]ield [O]ption " .. desc })
end

keymap_toggle_set("h", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, "Hints")
keymap_toggle_set("q", function()
	local qf_exists = vim.fn.getqflist({ winid = 0 }).winid ~= 0
	if qf_exists then
		vim.cmd.cclose()
	else
		vim.cmd.copen()
		vim.cmd.wincmd("p")
	end
end, "Quickfix")
keymap_toggle_set("l", function()
	local loc_exists = vim.fn.getloclist(0, { winid = 0 }).winid ~= 0
	if loc_exists then
		vim.cmd.lclose()
	else
		vim.cmd.lopen()
		vim.cmd.wincmd("p")
	end
end, "Loclist")
keymap_toggle_set("d", function()
	require("mini.diff").toggle_overlay(0)
end, "Diff Overlay")

keymap_set("n", "<leader>q", function()
	vim.diagnostic.setqflist({ open = true })
	vim.cmd.wincmd("p")
end, { desc = "Diagnostic [Q]uickfix (Workspace)" })
keymap_set("n", "<leader>l", function()
	vim.diagnostic.setloclist({ open = true })
	vim.cmd.wincmd("p")
end, { desc = "Diagnostic [L]oclist (Buffer)" })

keymap_set({ "n", "x" }, "gy", '"+y', { desc = "Copy to system" })
keymap_set("n", "gp", '"+p', { desc = "Paste from system" })
keymap_set("x", "gp", '"+P', { desc = "Paste from system (No register overwrite)" })
keymap_set("n", "go", "gO", { remap = true })

keymap_set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap_set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap_set("x", "J", ":move '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap_set("x", "K", ":move '<-2<CR>gv=gv", { desc = "Move selection up" })
keymap_set("x", "<", "<gv")
keymap_set("x", ">", ">gv")
keymap_set("n", "<BS>", "<cmd>nohlsearch<cr>")

keymap_set("n", "<C-d>", "<C-d>zz")
keymap_set("n", "<C-u>", "<C-u>zz")
keymap_set("n", "n", "nzzzv")
keymap_set("n", "N", "Nzzzv")

for key, dir in pairs({ h = "left", j = "bottom", k = "top", l = "right" }) do
	keymap_set("n", "<C-" .. key .. ">", "<C-w>" .. key, { desc = "Focus " .. dir })
	keymap_set("t", "<C-" .. key .. ">", [[<C-\><C-n><C-w>]] .. key)
end
keymap_set("t", "<Esc><Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
keymap_set("n", "<C-space>", "<Nop>")

keymap_set("n", "-", function()
	MiniFiles.open(vim.api.nvim_buf_get_name(0))
end, { desc = "Explorer (mini.files)" })
keymap_set("n", "<leader><leader>", function()
	MiniPick.builtin.resume()
end)
keymap_set("n", "<leader>f", function()
	MiniPick.builtin.files()
end)
keymap_set("n", "<leader>g", function()
	MiniExtra.pickers.git_files()
end)
keymap_set("n", "<leader>/", function()
	MiniPick.builtin.grep_live()
end)
