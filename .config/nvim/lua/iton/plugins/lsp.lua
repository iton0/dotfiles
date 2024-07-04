local M = require('iton.globals')
local keymap = M.map

return {
  -- Faster Lua LSP setup
  {
    'folke/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  'Bilal2453/luvit-meta', -- optional `vim.uv` typings

  -- LSP Configuration & Plugins
  {
    'neovim/nvim-lspconfig',
    event = M.prenew,
    cmd = { 'Mason', 'MasonToolsUpdateSync', 'MasonToolsInstallSync' },
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'hrsh7th/cmp-nvim-lsp',
    },
    build = ':MasonToolsUpdateSync',
    config = function()
      local _border = 'rounded'
      require('lspconfig.ui.windows').default_options.border = _border

      vim.diagnostic.config({
        float = {
          focusable = false,
          style = 'minimal',
          source = true,
          header = '',
          prefix = '',
          border = _border,
        },
      })

      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = _border,
        title = 'Hover Docs',
      })
      vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = _border,
        title = 'Signature Docs',
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP Specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilties with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Easier LSP Setup
      vim.api.nvim_create_autocmd('User', {
        pattern = 'MasonToolsUpdateCompleted',
        callback = function()
          vim.defer_fn(function()
            if not M.is_lsp_excluded_filetype() then
              vim.cmd('LspStart')
              vim.defer_fn(function()
                if next(vim.lsp.get_clients({ bufnr = vim.fn.bufnr('%') })) == nil then
                  vim.cmd('LspInstall')
                end
              end, 250)
            end
          end, 250)
        end,
      })

      --  This function gets run when an LSP connects to a particular buffer.
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(mode, keys, func, desc)
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('n', 'gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('n', 'gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('n', 'gi', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('n', 'gd', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          map('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
          map('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          map('n', 'gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Rename the variable under your cursor
          map('n', '<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map({ 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action, 'Code [A]ction')

          -- Show the signature of the function you're currently completing.
          map('n', '<C-s>', vim.lsp.buf.signature_help, '[S]ignature Documentation')

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('n', '<m-h>', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

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
        lua_ls = {
          -- cmd = {...},
          -- filetypes = { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              diagnostics = {
                disable = { 'missing-fields' },
              },
            },
          },
        },
        jdtls = {
          settings = {
            java = {
              configuration = {
                updateBuildConfiguration = 'automatic',
              },
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
        'lua_ls', -- Neovim/Lua
        'stylua',
        'clangd', -- C/C++
        'clang-format',
        'pyright', -- Python
        'black',
        'typescript-language-server', -- Web Dev
        'prettierd',
        'beautysh', -- Shell/Bash/Zsh
        'jdtls', -- Java (NOTE: use VS Code for more advanced usage)
        'google-java-format',
        'xmlformatter',
      })
      require('mason-tool-installer').setup({
        ensure_installed = ensure_installed,
        auto_update = true,
        run_on_start = true,
      })
      require('mason-lspconfig').setup({
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      })
    end,
    -- Check if LSP server is ready. If not, starts LSP or installs LSP.
    keymap('n', '<M-l>', function()
      if next(vim.lsp.get_clients({ bufnr = vim.fn.bufnr('%') })) ~= nil then
        print('LSP Already Installed')
        vim.defer_fn(function()
          vim.cmd('echo ""')
        end, 750)
      elseif M.is_lsp_excluded_filetype() then
        local input = vim.fn.input(' ' .. vim.bo.filetype .. ' is excluded from LSP. Proceed? (y/n) ')
        if input == 'y' then
          vim.cmd("echo ''")
          vim.cmd('LspInstall')
        elseif input == 'n' then
          vim.cmd("echo ''")
        else
          vim.cmd("echo 'Invalid input'")
          vim.defer_fn(function()
            vim.cmd("echo ''")
          end, 750)
        end
      else
        vim.cmd('LspStart')
        vim.defer_fn(function()
          if next(vim.lsp.get_clients({ bufnr = vim.fn.bufnr('%') })) == nil then
            vim.cmd('MasonToolsInstall')
          end
        end, 250)
      end
    end, { desc = 'LSP Install' }),
  },
}
