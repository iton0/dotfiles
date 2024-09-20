return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  keys = {
    { '<leader>b' },
  },
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

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

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup({
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '+', collapsed = '-', current_frame = '●' },
      controls = {
        icons = {
          pause = '||',
          play = '▶',
          step_into = '↓',
          step_over = '→',
          step_out = '↑',
          step_back = '←',
          run_last = '▶▶',
          terminate = '■',
          disconnect = '✖',
        },
      },
    })

    local sign = vim.fn.sign_define
    sign('DapBreakpoint', { text = '◉' })
    sign('DapBreakpointCondition', { text = '◉' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<leader>bs', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<leader>bi', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<leader>br', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<leader>bo', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set(
      'n',
      '<leader>bb',
      dap.toggle_breakpoint,
      { desc = 'Debug: Toggle Breakpoint' }
    )
    vim.keymap.set('n', '<leader>bc', function()
      dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
    end, { desc = 'Debug: Set Breakpoint' })
    vim.keymap.set('n', '<leader>bt', function()
      vim.cmd('NoNeckPain')
      dapui.toggle({ reset = true })
    end, { desc = 'Debug: See last session result.' })

    -- Install language specific config here

    -- require('dap-go').setup({
    --   delve = {
    --     -- On Windows delve must be run attached or it crashes.
    --     -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
    --     detached = vim.fn.has('win32') == 0,
    --   },
    -- })
  end,
}
