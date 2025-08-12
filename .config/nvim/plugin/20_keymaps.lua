local later = _G.MyConfig.later

later(function()
	local map = function(mode, lhs, rhs, opts)
		opts = opts or {}
		vim.keymap.set(mode, lhs, rhs, opts)
	end

	map("n", "k", function() return vim.v.count == 0 and "gk" or "k" end, { expr = true, silent = true })
	map("n", "j", function() return vim.v.count == 0 and "gj" or "j" end, { expr = true, silent = true })
	map("n", "<leader>r", ":%s/\\v", { desc = "Find and Replace" })
	map("x", "<leader>r", ":s/\\v", { desc = "Find and Replace (Visual)" })
	map("n", "<M-r>", ":cdo s/\\v", { desc = "Quickfix Find and Replace" })
	map("n", "<c-space>", "<Nop>", { desc = "Tmux Conflict Prevention" })
	map("x", "<c-y>", '"+y', { desc = "Yank to System Clipboard", silent = true })
	map("n", "<m-k>", ":m .-2<CR>==", { silent = true })
	map("n", "<m-j>", ":m .+1<CR>==", { silent = true })
	map("x", "<M-k>", ":m '<-2<CR>gv=gv", { silent = true })
	map("x", "<M-j>", ":m '>+1<CR>gv=gv", { silent = true })
	map("x", "<", "<gv")
	map("x", ">", ">gv")
	map("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
	map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom split" })
	map("n", "<C-k>", "<C-w>k", { desc = "Move to top split" })
	map("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })
	map("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Move to left split" })
	map("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Move to bottom split" })
	map("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Move to top split" })
	map("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Move to right split" })
	map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
	map("n", "<leader>b", function()
		if vim.o.background == "dark" then
			vim.o.background = "light"
		else
			vim.o.background = "dark"
		end
	end, { desc = "Toggle Background (Dark/Light)" })
	map("n", "<BS>", "<cmd>nohlsearch<CR>", { silent = true })
	map("i", "<C-c>", "<C-x><C-o>", { desc = "Trigger LSP autocomplete" })
	map({ "n", "x" }, "<leader>s", function()
		vim.lsp.buf.format({ async = true })
	end, { desc = "LSP Format" })
	map("n", "<leader>ew", function()
		vim.diagnostic.setqflist({ title = "Workspace Diagnostics" })
	end)
	map("n", "<leader>el", function()
		vim.diagnostic.setloclist({ title = "File Diagnostics" })
	end)
	map(
		"n",
		"<leader>l",
		function()
			local qf = vim.fn.getloclist(0, { winid = 0, items = 0 })
			if qf.winid ~= 0 then
				vim.cmd.lclose()
			elseif #qf.items > 0 then
				vim.cmd.lopen()
			else
				vim.notify("Location list empty", vim.log.levels.WARN)
			end
		end,
		{ desc = "Toggle Location List" }
	)
	map(
		"n",
		"<leader>w",
		function()
			local qf = vim.fn.getqflist({ winid = 0, items = 0 })
			if qf.winid ~= 0 then
				vim.cmd.cclose()
			elseif #qf.items > 0 then
				vim.cmd.copen()
			else
				vim.notify("Quickfix empty", vim.log.levels.WARN)
			end
		end,
		{ desc = "Toggle Quickfix List" }
	)
	map("n", "-", "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0), false)<cr>",
		{ desc = "Open File System Explorer" })
	map("n", "<leader><leader>", "<cmd>lua MiniPick.builtin.resume()<cr>", { desc = "Opens the previous picker" })
	map("n", "<leader>/", "<cmd>lua MiniPick.builtin.grep_live()<cr>", { desc = "Search by Grep" })
	map("n", "<leader>f", "<cmd>lua MiniPick.builtin.files()<cr>", { desc = "Search Files (fd/git toggle)" })
	map("n", "<leader>g", "<cmd>lua MiniPick.builtin.files({ tool = 'git' })<cr>",
		{ desc = "Search Files (fd/git toggle)" })
	map("n", "<leader>dd", function() require("dap").toggle_breakpoint() end, { desc = "Breakpoint Toggle" })
	map("n", "<leader>dc", function() require("dap").continue() end, { desc = "Continue" })
	map("n", "<leader>di", function() require("dap").step_into() end, { desc = "Step Into" })
	map("n", "<leader>dn", function() require("dap").step_over() end, { desc = "Step Over (Next)" })
	map("n", "<leader>do", function() require("dap").step_out() end, { desc = "Step Out" })
	map("n", "<leader>dl", function() require("dap").run_last() end, { desc = "Last Run" })
	map("n", "<leader>dr", function() require("dap").restart() end, { desc = "Restart" })
	map("n", "<leader>dx", function() require("dap").terminate() end, { desc = "Terminate" })
	map("n", "<leader>dv", function() require("dap-view").toggle() end, { desc = "View Toggle" })
	map("n", "<leader>dt", function()
		require("dap").set_breakpoint(vim.fn.input("Debug Condition: "))
	end, { desc = "Conditional Breakpoint" })

	map("n", "<leader>dp", function()
		require("dap").set_breakpoint(nil, nil, vim.fn.input("Log Point: "))
	end, { desc = "Log Point" })
end)
