--  The configuration is done below. Search for lspconfig to find it below.
return {
  -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    {
      'williamboman/mason.nvim',
      -- config = true,
      dependencies = {
        {
          'williamboman/mason-lspconfig.nvim',
          opts = {
            automatic_installation = true,
          },
        },
        {
          'WhoIsSethDaniel/mason-tool-installer.nvim',
          opts = {
            auto_update = true,
            run_on_start = true,
            start_delay = 3000,
            debounce_hours = 5,
          },
        },
      },
      opts = {
        ui = {
          icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗',
          },
        },
      },
    },

    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    {
      'j-hui/fidget.nvim',
      tag = 'legacy',
      event = 'LspAttach',
      opts = {},
    },

    -- Additional lua configuration, makes nvim stuff amazing!
    {
      'folke/neodev.nvim',
      opts = {
        library = {
          plugins = { 'nvim-dap-ui' },
          types = true,
        },
      },
    },
  },
}
