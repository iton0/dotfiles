local M = require('iton.constants')
local map = M.map

return {
  -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  event = M.prenew,
  cmd = { 'Mason', 'MasonToolsUpdateSync', 'MasonToolsInstallSync' },
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'folke/neodev.nvim', opts = {} },
  },
  build = ':MasonToolsUpdateSync',
  config = function()
    local _border = 'rounded'
    require('lspconfig.ui.windows').default_options.border = _border

    vim.diagnostic.config({
      float = {
        focusable = false,
        style = 'minimal',
        source = 'always',
        header = '',
        prefix = '',
        border = _border,
      },
    })

    vim.lsp.handlers['textDocument/hover'] =
      vim.lsp.with(vim.lsp.handlers.hover, {
        border = _border,
        title = 'Hover Docs',
      })
    vim.lsp.handlers['textDocument/signatureHelp'] =
      vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = _border,
        title = 'Signature Docs',
      })

    -- LSP servers and clients are able to communicate to each other what features they support.
    --  By default, Neovim doesn't support everything that is in the LSP Specification.
    --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
    --  So, we create new capabilties with nvim cmp, and then broadcast that to the servers.
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend(
      'force',
      capabilities,
      require('cmp_nvim_lsp').default_capabilities()
    )

    -- Enable the following language servers
    --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
    --
    --  Add any additional override configuration in the following tables. Available keys are:
    --  - cmd (table): Override the default command used to start the server
    --  - filetypes (table): Override the default list of associated filetypes for the server
    --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
    --  - settings (table): Override the default settings passed when initializing the server.
    --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
    local servers = {
      -- clangd = {},
      -- gopls = {},
      -- rust_analyzer = {},
      -- html = { filetypes = { 'html', 'twig', 'hbs'} },
      -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
      --
      -- If you use something like typescript, where the tooling is as bad as the language,
      -- then you might need to install and configure something like this:
      --    https://github.com/pmizio/typescript-tools.nvim
      --
      -- If you only have simple needs for typescript, then you can probably just use tsserver
      -- tsserver = {},
      lua_ls = {
        -- cmd = {...},
        -- filetypes = { ...},
        -- capabilities = {},
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
            diagnostics = { disable = { 'missing-fields' } },
          },
        },
      },
    }

    -- Ensure the servers above are installed
    require('mason').setup({
      ui = {
        border = _border,
        icons = {
          package_installed = '✓',
          package_pending = '',
          package_uninstalled = '✗',
        },
      },
    })
    -- You can add other tools here that you want Mason to install
    -- for you, so that they are available from within Neovim.
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua', -- For Neovim
      'lua_ls',
      'clang-format', -- C/C++
      'clangd',
      'black', -- Python
      'pyright',
      'typescript-language-server', -- Web Dev
      'prettierd',
    })
    require('mason-tool-installer').setup({
      ensure_installed = ensure_installed,
      auto_update = true,
      run_on_start = false,
    })
    require('mason-lspconfig').setup({
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for tsserver)
          server.capabilities = vim.tbl_deep_extend(
            'force',
            {},
            capabilities,
            server.capabilities or {}
          )
          require('lspconfig')[server_name].setup(server)
        end,
      },
    })
  end,
  -- Check if LSP server is ready. If not, starts LSP or installs LSP.
  map('n', '<M-l>', function()
    if vim.lsp.buf.server_ready() then
      print(' LSP Already Installed')
      vim.defer_fn(function()
        vim.cmd('echo ""')
      end, 1000)
    else
      vim.cmd('LspStart')
      vim.defer_fn(function()
        if vim.lsp.buf.server_ready() then
          vim.cmd('echo ""')
        else
          vim.cmd('MasonToolsInstall')
        end
      end, 500)
    end
  end, true, true, 'LSP Install'),
}
