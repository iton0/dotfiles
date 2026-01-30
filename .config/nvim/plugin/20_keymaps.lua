local map = function(mode, lhs, rhs, opts)
	opts = opts or {}
	vim.keymap.set(mode, lhs, rhs, opts)
end

-- Navigation & Visual
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("x", "<", "<gv") -- Indent and keep selection
map("x", ">", ">gv") -- Outdent and keep selection

-- Line manipulation
map("n", "<M-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
map("n", "<M-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("x", "<M-k>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })
map("x", "<M-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })

-- System Clipboard
map("x", "<C-y>", '"+y', { desc = "Yank to system clipboard" })

-- Search & Replace
map("n", "<BS>", "<cmd>nohlsearch<cr>", { desc = "Clear highlights" })
map("n", "<leader>r", ":%s/\\v", { desc = "Global replace (Magic)" })
map("x", "<leader>r", ":s/\\v", { desc = "Selection replace (Magic)" })
map("n", "<M-r>", ":cdo s/\\v", { desc = "Quickfix replace (Magic)" })

-- Splits & Terminal
local directions = { h = "left", j = "bottom", k = "top", l = "right" }
for key, dir in pairs(directions) do
	map("n", "<C-" .. key .. ">", "<C-w>" .. key, { desc = "Focus " .. dir })
	map("t", "<C-" .. key .. ">", [[<C-\><C-n><C-w>]] .. key, { desc = "Focus " .. dir })
end
map("t", "<Esc><Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
map("n", "<C-space>", "<Nop>", { desc = "Tmux conflict prevention" })

-- LSP & Diagnostics
map("i", "<C-c>", "<C-x><C-o>", { desc = "Manual completion" })
map("n", "<C-f>", function()
	vim.lsp.buf.format({ async = true })
end, { desc = "Format" })
map("n", "<M-h>", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle Inlay Hints" })

-- List Toggles (Quickfix & Loclist)
map("n", "<leader>l", function()
	local qf = vim.fn.getloclist(0, { winid = 0, items = 0 })
	if qf.winid ~= 0 then
		vim.cmd.lclose()
	elseif #qf.items > 0 then
		vim.cmd.lopen()
	else
		vim.notify("Location list empty", 3)
	end
end, { desc = "Toggle Location List" })

map("n", "<leader>q", function()
	local qf = vim.fn.getqflist({ winid = 0, items = 0 })
	if qf.winid ~= 0 then
		vim.cmd.cclose()
	elseif #qf.items > 0 then
		vim.cmd.copen()
	else
		vim.notify("Quickfix list empty", 3)
	end
end, { desc = "Toggle Quickfix List" })

map("n", "<leader>w", vim.diagnostic.setqflist, { desc = "Workspace Diagnostics -> QF" })
map("n", "<leader>e", vim.diagnostic.setloclist, { desc = "File Diagnostics -> Loclist" })

-- Mini.nvim integrations
map("n", "-", "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0), false)<cr>", { desc = "Explorer" })
map("n", "<leader><leader>", "<cmd>lua MiniPick.builtin.resume()<cr>", { desc = "Resume Picker" })
map("n", "<leader>/", "<cmd>lua MiniPick.builtin.grep_live()<cr>", { desc = "Grep Search" })
map("n", "<leader>f", "<cmd>lua MiniPick.builtin.files()<cr>", { desc = "Find Files" })
map("n", "<leader>g", "<cmd>lua MiniPick.builtin.files({ tool = 'git' })<cr>", { desc = "Git Files" })

-- Debugger (DAP)
local dap_map = {
	d = {
		function()
			require("dap").toggle_breakpoint()
		end,
		"Breakpoint",
	},
	t = {
		function()
			require("dap").set_breakpoint(vim.fn.input("Condition: "))
		end,
		"Cond Breakpoint",
	},
	p = {
		function()
			require("dap").set_breakpoint(nil, nil, vim.fn.input("Log: "))
		end,
		"Log Point",
	},
	c = {
		function()
			require("dap").continue()
		end,
		"Continue",
	},
	i = {
		function()
			require("dap").step_into()
		end,
		"Step Into",
	},
	n = {
		function()
			require("dap").step_over()
		end,
		"Step Over",
	},
	o = {
		function()
			require("dap").step_out()
		end,
		"Step Out",
	},
	r = {
		function()
			require("dap").restart()
		end,
		"Restart",
	},
	x = {
		function()
			require("dap").terminate()
		end,
		"Terminate",
	},
	v = {
		function()
			require("dap-view").toggle()
		end,
		"Toggle UI",
	},
}
for k, v in pairs(dap_map) do
	map("n", "<leader>d" .. k, v[1], { desc = "Debug: " .. v[2] })
end
