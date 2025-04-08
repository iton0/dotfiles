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
				"python",
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
			python = {
				{
					-- The first three options are required by nvim-dap
					type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
					request = "launch",
					name = "Launch file",

					-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

					program = "${file}", -- This configuration will launch the current file if used.
					pythonPath = function()
						-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
						-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
						-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
						local cwd = vim.fn.getcwd()
						if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
							return cwd .. "/venv/bin/python"
						elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
							return cwd .. "/.venv/bin/python"
						else
							return "/usr/bin/python"
						end
					end,
				},
			},
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
		map("n", "<leader>dt", dap.toggle_breakpoint, { desc = "Toggle Breakpoint", nowait = true, remap = false })
		map("n", "<leader>dc", dap.continue, { desc = "Continue", nowait = true, remap = false })
		map("n", "<leader>dsi", dap.step_into, { desc = "Step Into", nowait = true, remap = false })
		map("n", "<leader>dso", dap.step_over, { desc = "Step Over", nowait = true, remap = false })
		map("n", "<leader>dsu", dap.step_out, { desc = "Step Out", nowait = true, remap = false })
		map("n", "<leader>dsb", dap.step_back, { desc = "Step Back", nowait = true, remap = false })
		map("n", "<leader>dr", dap.restart, { desc = "Restart", nowait = true, remap = false })
		map("n", "<leader>du", ui.toggle, { desc = "Toggle UI", nowait = true, remap = false })
		map("n", "<leader>dq", function()
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
