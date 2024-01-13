return {
  -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  cmd = {
    'LspStart',
    'LspInstall',
    'LspUninstall',
    'Mason',
    'MasonToolsInstall',
  },
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    {
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      opts = {
        ensure_installed = {
          'lua-language-server', -- For Neovim (DO NOT DELETE)
          'stylua',
          'codespell', -- Check code for common misspellings
          'clang-format', -- C/C++
          'clangd',
          'cpplint',
          'css-lsp', -- Web Dev
          'typescript-language-server',
          'html-lsp',
          'eslint_d',
          'stylelint',
          'prettierd',
        },
        auto_update = true,
        run_on_start = false,
      },
    },

    -- Additional lua configuration, makes nvim stuff amazing!
    'folke/neodev.nvim',
  },
  build = ':MasonToolsUpdate',
  config = function()
    -- [[ Configure LSP ]]
    --  This function gets run when an LSP connects to a particular buffer.
    local on_attach = function(_, bufnr)
      -- NOTE: Remember that lua is a real programming language, and as such it is possible
      -- to define small helper and utility functions so you don't have to repeat yourself
      -- many times.
      --
      -- In this case, we create a function that lets us more easily define mappings specific
      -- for LSP related items. It sets the mode, buffer and description for us each time.
      local nmap = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end

      nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
      nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

      nmap(
        'gd',
        require('telescope.builtin').lsp_definitions,
        '[G]oto [D]efinition'
      )
      nmap(
        'gr',
        require('telescope.builtin').lsp_references,
        '[G]oto [R]eferences'
      )
      nmap(
        'gI',
        require('telescope.builtin').lsp_implementations,
        '[G]oto [I]mplementation'
      )
      nmap(
        '<leader>dd',
        require('telescope.builtin').lsp_type_definitions,
        'Type [D]efinition'
      )
      nmap(
        '<leader>ds',
        require('telescope.builtin').lsp_document_symbols,
        '[D]ocument [S]ymbols'
      )
      nmap(
        '<leader>ws',
        require('telescope.builtin').lsp_dynamic_workspace_symbols,
        '[W]orkspace [S]ymbols'
      )

      -- Define custom signs for different diagnostic types (Error, Warn, Hint, Info)
      local signs = {
        Error = '󰅚 ', -- Custom sign for Errors
        Warn = '󰀪 ', -- Custom sign for Warnings
        Hint = '󰌶 ', -- Custom sign for Hints
        Info = ' ', -- Custom sign for Information messages
      }

      -- Loop through diagnostic types and set custom sign definitions
      for type, icon in pairs(signs) do
        local hl = 'DiagnosticSign' .. type -- Create highlight group name
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl }) -- Define sign with custom icon and highlight
      end

      -- Switch for controlling whether you want autoformatting.
      --  Use :KickstartFormatToggle to toggle autoformatting on or off
      local format_is_enabled = true
      vim.api.nvim_create_user_command('KickstartFormatToggle', function()
        format_is_enabled = not format_is_enabled
        print('Setting autoformatting to: ' .. tostring(format_is_enabled))
      end, {})

      -- Create an augroup that is used for managing our formatting autocmds.
      --      We need one augroup per client to make sure that multiple clients
      --      can attach to the same buffer without interfering with each other.
      local _augroups = {}
      local get_augroup = function(client)
        if not _augroups[client.id] then
          local group_name = 'kickstart-lsp-format-' .. client.name
          local id = vim.api.nvim_create_augroup(group_name, { clear = true })
          _augroups[client.id] = id
        end

        return _augroups[client.id]
      end

      -- Whenever an LSP attaches to a buffer, we will run this function.
      --
      -- See `:help LspAttach` for more information about this autocmd event.
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup(
          'kickstart-lsp-attach-format',
          { clear = true }
        ),
        -- This is where we attach the autoformatting for reasonable clients
        callback = function(args)
          local client_id = args.data.client_id
          local client = vim.lsp.get_client_by_id(client_id)
          local bfnr = args.buf

          -- Only attach to clients that support document formatting
          if not client.server_capabilities.documentFormattingProvider then
            return
          end

          -- Tsserver usually works poorly. Sorry you work with bad languages
          -- You can remove this line if you know what you're doing :)
          if client.name == 'tsserver' then
            return
          end

          -- Create an autocmd that will run *before* we save the buffer.
          --  Run the formatting command for the LSP that has just attached.
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = get_augroup(client),
            buffer = bfnr,
            callback = function()
              if not format_is_enabled then
                return
              end

              vim.lsp.buf.format({
                async = false,
                filter = function(c)
                  return c.id == client.id
                end,
              })
            end,
          })
        end,
      })
      -- See `:help K` for why this keymap
      nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
      nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

      -- Lesser used LSP functionality
      nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      nmap(
        '<leader>wa',
        vim.lsp.buf.add_workspace_folder,
        '[W]orkspace [A]dd Folder'
      )
      nmap(
        '<leader>wr',
        vim.lsp.buf.remove_workspace_folder,
        '[W]orkspace [R]emove Folder'
      )
      nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, '[W]orkspace [L]ist Folders')

      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
      end, { desc = 'Format current buffer with LSP' })
    end

    require('lspconfig.ui.windows').default_options.border = 'rounded'

    -- Autocommand that executes after
    -- MasonToolInstall finishes. Makes
    -- it easier for LSP setup
    vim.api.nvim_create_autocmd('User', {
      pattern = 'MasonToolsUpdateCompleted',
      callback = function()
        vim.schedule(function()
          vim.cmd('LspStart')
          vim.defer_fn(function()
            if vim.lsp.buf.server_ready() then
              vim.cmd('echo ""')
            else
              vim.cmd('LspInstall')
              vim.defer_fn(function()
                vim.cmd('LspStart')
              end, 5000)
            end
          end, 1000)
        end)
      end,
    })

    -- mason-lspconfig requires that these setup functions are called in this order
    -- before setting up the servers.
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
    require('mason-lspconfig').setup({})
    -- Enable the following language servers
    --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
    --
    --  Add any additional override configuration in the following tables. They will be passed to
    --  the `settings` field of the server config. You must look up that documentation yourself.
    --
    --  If you want to override the default filetypes that your language server will attach to you can
    --  define the property 'filetypes' to the map in question.
    local servers = {
      lua_ls = {
        Lua = {
          codeLens = { enable = true },
          completion = { callSnippet = 'Replace' },
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
          diagnostics = { disable = { 'missing-fields' } },
        },
      },
    }

    -- Setup neovim lua configuration
    require('neodev').setup({})

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    -- Ensure the servers above are installed
    local mason_lspconfig = require('mason-lspconfig')

    mason_lspconfig.setup_handlers({
      function(server_name)
        require('lspconfig')[server_name].setup({
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
          filetypes = (servers[server_name] or {}).filetypes,
        })
      end,
    })
  end,
}
