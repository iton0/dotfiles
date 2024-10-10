return {
	"mfussenegger/nvim-dap",
	keys = {
		{ "<leader>b" },
	},
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",

		-- Add your own debuggers here
		{ "leoluz/nvim-dap-go", config = true },
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		require("mason-nvim-dap").setup({
			automatic_installation = true,

			-- You can provide additional configuration to the handlers,
			-- see mason-nvim-dap README for more information
			handlers = {},

			ensure_installed = {
				-- Update this to ensure that you have the debuggers for the langs you want
				"delve",
			},
		})

		dapui.setup({
			icons = { expanded = "+", collapsed = "-", current_frame = "●" },
			controls = {
				icons = {
					pause = "||",
					play = "▶",
					step_into = "↓",
					step_over = "→",
					step_out = "↑",
					step_back = "←",
					run_last = "▶▶",
					terminate = "■",
					disconnect = "✖",
				},
			},
		})

		local sign = vim.fn.sign_define
		sign("DapBreakpoint", { text = "●" })
		sign("DapBreakpointCondition", { text = "◉" })

		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		vim.keymap.set("n", "<leader>bs", dap.continue, { desc = "Debug: Start/Continue" })
		vim.keymap.set("n", "<leader>bi", dap.step_into, { desc = "Debug: Step Into" })
		vim.keymap.set("n", "<leader>br", dap.step_over, { desc = "Debug: Step Over" })
		vim.keymap.set("n", "<leader>bo", dap.step_out, { desc = "Debug: Step Out" })
		vim.keymap.set("n", "<leader>bb", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
		vim.keymap.set("n", "<leader>bc", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "Debug: Set Breakpoint" })
		vim.keymap.set("n", "<leader>bt", function()
			dapui.toggle({ reset = true })
		end, { desc = "Debug: See last session result." })

		-- Setup language specific config here
	end,
}
