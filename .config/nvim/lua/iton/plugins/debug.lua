local M = require('iton.globals')
local map = M.map

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  keys = { { '<leader>b' } },
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    { 'rcarriga/nvim-dap-ui', opts = {} },

    -- Adds virtual text support
    {
      'theHamsta/nvim-dap-virtual-text',
      dependencies = 'nvim-treesitter/nvim-treesitter',
      opts = {},
    },

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
  },
  config = function()
    local dap = require('dap')
    local dapui = require('dapui')
    require('nvim-dap-virtual-text').setup({})

    require('mason-nvim-dap').setup({
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
      },
    })
    -- Basic debugging keymaps, feel free to change to your liking!
    map('n', '<leader>bs', function()
      dap.continue()
      vim.cmd('NoNeckPain')
    end, { desc = 'Debug: Start/Continue' })
    map('n', '<leader>bi', dap.step_into, { desc = 'Debug: Step Into' })
    map('n', '<leader>bv', dap.step_over, { desc = 'Debug: Step Over' })
    map('n', '<leader>bo', dap.step_out, { desc = 'Debug: Step Out' })
    map(
      'n',
      '<leader>bt',
      dap.toggle_breakpoint,
      { desc = 'Debug: Toggle Breakpoint' }
    )
    map('n', '<leader>bc', function()
      dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
    end, { desc = 'Debug: Set Breakpoint' })

    vim.fn.sign_define(
      'DapBreakpoint',
      { text = '', texthl = 'ErrorMsg', linehl = '', numhl = '' }
    )
    vim.fn.sign_define(
      'DapBreakpointCondition',
      { text = '', texthl = 'ErrorMsg', linehl = '', numhl = '' }
    )
    vim.fn.sign_define(
      'DapLogPoint',
      { text = '', texthl = 'ErrorMsg', linehl = '', numhl = '' }
    )
    vim.fn.sign_define('DapStopped', {
      text = '',
      texthl = 'ErrorMsg',
      linehl = 'Substitute',
      numhl = 'Substitute',
    })
    vim.fn.sign_define(
      'DapBreakpointRejected',
      { text = '', texthl = 'WarningMsg', linehl = '', numhl = '' }
    )

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    map('n', '<leader>bu', function()
      dapui.toggle()
      vim.cmd('NoNeckPain')
    end, { desc = 'Debug: Toggle UI' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install language specific config
  end,
}
