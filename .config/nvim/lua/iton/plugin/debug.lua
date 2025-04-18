local M = require("iton.util")
local map = M.map

return {
	"mfussenegger/nvim-dap",
	keys = { { "<leader>d" } },
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"jay-babu/mason-nvim-dap.nvim",
		"theHamsta/nvim-dap-virtual-text",
	},
	config = function()
		local mason_dap = require("mason-nvim-dap")
		local dap = require("dap")
		local ui = require("dapui")
		local dap_virtual_text = require("nvim-dap-virtual-text")

		-- Dap Virtual Text
		dap_virtual_text.setup()
		-- Dap UI
		ui.setup()

		mason_dap.setup({
			ensure_installed = {
				"cppdbg",
				"delve",
			},
			automatic_installation = true,
			handlers = {
				function(config)
					require("mason-nvim-dap").default_setup(config)
				end,
			},
		})

		-- Configurations
		dap.configurations = {
			go = {
				{
					type = "delve",
					name = "Debug",
					request = "launch",
					program = "${file}",
				},
				{
					type = "delve",
					name = "Debug test", -- configuration for debugging test files
					request = "launch",
					mode = "test",
					program = "${file}",
				},
				-- works with go.mod packages and sub packages
				{
					type = "delve",
					name = "Debug test (go.mod)",
					request = "launch",
					mode = "test",
					program = "./${relativeFileDirname}",
				},
			},
			c = {
				{
					name = "Launch file",
					type = "cppdbg",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopAtEntry = true,
				},
				{
					name = "Attach to gdbserver :1234",
					type = "cppdbg",
					request = "launch",
					MIMode = "gdb",
					miDebuggerServerAddress = "localhost:1234",
					miDebuggerPath = "/usr/bin/gdb",
					cwd = "${workspaceFolder}",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
				},
			},
		}

		-- DAP keymaps
		map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint", nowait = true, remap = false })
		map("n", "<leader>dc", dap.continue, { desc = "Continue", nowait = true, remap = false })
		map("n", "<leader>di", dap.step_into, { desc = "Step Into", nowait = true, remap = false })
		map("n", "<leader>do", dap.step_over, { desc = "Step Over", nowait = true, remap = false })
		map("n", "<leader>du", dap.step_out, { desc = "Step Out", nowait = true, remap = false })
		map("n", "<leader>dk", dap.step_back, { desc = "Step Back", nowait = true, remap = false })
		map("n", "<leader>dr", dap.restart, { desc = "Restart", nowait = true, remap = false })
		map("n", "<leader>dl", ui.toggle, { desc = "Toggle UI", nowait = true, remap = false })
		map("n", "<leader>dx", function()
			dap.terminate()
			ui.close()
			dap_virtual_text.toggle()
		end, { desc = "Terminate", nowait = true, remap = false })

		dap.listeners.before.attach.dapui_config = function()
			ui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			ui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			ui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			ui.close()
		end
	end,
}
