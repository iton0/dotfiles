return {
  -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  event = { 'BufReadPost', 'BufNewFile' },
  cmd = 'Mason',
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    -- Additional lua configuration, makes nvim stuff amazing!
    'folke/neodev.nvim',
  },
  build = ':MasonToolsUpdate',
  config = function()
    -- [[ Configure LSP ]]

    -- Setup neovim lua configuration
    require('neodev').setup({})

    -- Better ui for LSP realated popups with transparent colorscheme
    require('lspconfig.ui.windows').default_options.border = 'rounded'

    vim.lsp.handlers['textDocument/hover'] =
      vim.lsp.with(vim.lsp.handlers.hover, {
        -- Use a sharp border with `FloatBorder` highlights
        border = 'rounded',
        -- add the title in hover float window
        title = 'Hover Docs',
      })

    vim.lsp.handlers['textDocument/signatureHelp'] =
      vim.lsp.with(vim.lsp.handlers.signature_help, {
        -- Use a sharp border with `FloatBorder` highlights
        border = 'rounded',
        title = 'Signature Docs',
      })

    --  This function gets run when an LSP connects to a particular buffer.
    --  This function gets run when an LSP connects to a particular buffer.
    --    That is to say, every time a new file is opened that is associated with
    --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
    --    function will be executed to configure the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup(
        'kickstart-lsp-attach',
        { clear = true }
      ),
      callback = function(event)
        -- NOTE: Remember that lua is a real programming language, and as such it is possible
        -- to define small helper and utility functions so you don't have to repeat yourself
        -- many times.
        --
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local map = function(keys, func, desc)
          vim.keymap.set(
            'n',
            keys,
            func,
            { buffer = event.buf, desc = 'LSP: ' .. desc }
          )
        end

        -- Important LSP Navigation keybinds
        --
        -- Jump to the definition of the word under your cursor.
        --  To jump back, press <C-T>.
        map(
          'gd',
          require('telescope.builtin').lsp_definitions,
          '[G]oto [D]efinition'
        )
        map(
          'gr',
          require('telescope.builtin').lsp_references,
          '[G]oto [R]eferences'
        )
        map(
          'gI',
          require('telescope.builtin').lsp_implementations,
          '[G]oto [I]mplementation'
        )
        map(
          '<leader>D',
          require('telescope.builtin').lsp_type_definitions,
          'Type [D]efinition'
        )
        map(
          '<leader>ds',
          require('telescope.builtin').lsp_document_symbols,
          '[D]ocument [S]ymbols'
        )
        map(
          '<leader>ws',
          require('telescope.builtin').lsp_dynamic_workspace_symbols,
          '[W]orkspace [S]ymbols'
        )

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        -- Rename the variable under your cursor
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        -- See `:help K` for why this keymap
        map('K', vim.lsp.buf.hover, 'Hover Documentation')

        -- Show the signature of the function you're currently completing.
        map('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
      end,
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

      jdtls = {
        settings = {
          redhat = { telemetry = { enabled = false } },
        },
      },
      pyright = {
        settings = {
          python = {
            analysis = { typeCheckingMode = 'strict' },
          },
        },
      },
      lua_ls = {
        -- cmd = {...},
        -- filetypes { ...},
        -- capabilities = {},
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            completion = { callSnippet = 'Replace' },
            workspace = {
              checkThirdParty = false,
              -- Tells lua_ls where to find all the Lua files that you have loaded
              -- for your neovim configuration.
              library = {
                '${3rd}/luv/library',
                unpack(vim.api.nvim_get_runtime_file('', true)),
              },
              -- If lua_ls is really slow on your computer, you can try this instead:
              -- library = { vim.env.VIMRUNTIME },
            },
            diagnostics = { disable = { 'missing-fields' } },
          },
        },
      },
    }

    -- Ensure the servers above are installed
    --  To check the current status of installed tools and/or manually install
    --  other tools, you can run
    --    :Mason
    --
    --  You can press `g?` for help in this menu
    require('mason').setup({
      ui = {
        border = 'rounded',
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
      'stylua', -- For Neovim WARN: Do not delete
      'clang-format', -- C/C++
      'clangd',
      'cpplint',
      'black', -- Python
      'typescript-language-server', -- Web Dev
      'html-lsp',
      'eslint_d',
      'stylelint',
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
          require('lspconfig')[server_name].setup({
            cmd = server.cmd,
            settings = server.settings,
            filetypes = server.filetypes,
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            capabilities = vim.tbl_deep_extend(
              'force',
              {},
              capabilities,
              server.capabilities or {}
            ),
          })
        end,
      },
    })
  end,
}
