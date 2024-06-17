return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    opts = {
      color_icons = false,
    },
  },
  config = function()
    -- Custom lualine layout
    local branch = {
      'branch',
      icons_enabled = false,
      color = { gui = 'bold' },
    }
    local filename = {
      'filename',
      path = 4,
      newfile_status = true,
      padding = { left = 0, right = 0 },
      color = { gui = 'bold' },
    }
    local diagnostics = {
      'diagnostics',
      symbols = { error = 'E-', warn = 'W-', info = 'I-', hint = 'H-' },
    }
    local lsp = {
      function()
        local msg = 'No LSP'
        local clients = vim.lsp.get_clients({ bufnr = 0 })

        return #clients > 0
            and table.concat(
              vim.tbl_map(function(client)
                return client.name
              end, clients),
              ','
            )
          or msg
      end,
      padding = { left = 0, right = 1 },
    }
    local diff = {
      'diff',
      colored = false,
      padding = { left = 1, right = 0 },
    }
    local lazy = {
      require('lazy.status').updates,
      cond = require('lazy.status').has_updates,
      color = { fg = '#ff9e64' },
      padding = { left = 0, right = 1 },
    }
    local filetype = {
      'filetype',
      colored = false,
      icon_only = true,
      padding = { left = 0, right = 0 },
    }
    local location = {
      'location',
      left_padding = 2,
      color = { gui = 'bold' },
    }
    require('lualine').setup({
      options = {
        theme = 'lackluster',
        globalstatus = true,
        always_divide_middle = false,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = { 'lazy', 'mason', 'TelescopePrompt' },
      },
      sections = {
        lualine_a = {},
        lualine_b = { branch, diff },
        lualine_c = { '%=', filetype, filename },
        lualine_x = { diagnostics, lsp },
        lualine_y = { lazy, location },
        lualine_z = {},
      },
    })
  end,
}
