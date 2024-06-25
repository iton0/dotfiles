local M = require('iton.constants')

return {
  'nvim-lualine/lualine.nvim',
  event = M.postnew,
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    local everforest = require('everforest')
    local colors = require('everforest.colours')
    local palette = colors.generate_palette(everforest.config, vim.o.background)
    local custom_everforest = require('lualine.themes.everforest')
    custom_everforest.normal.a = { bg = palette.bg3, fg = palette.grey2 }
    custom_everforest.insert.a = { bg = palette.bg3, fg = palette.grey2 }
    custom_everforest.visual.a = { bg = palette.bg3, fg = palette.grey2 }
    custom_everforest.command.a = { bg = palette.bg3, fg = palette.grey2 }
    custom_everforest.terminal.a = { bg = palette.bg3, fg = palette.grey2 }
    custom_everforest.normal.b = { bg = palette.bg1, fg = palette.grey1 }
    custom_everforest.insert.b = { bg = palette.bg1, fg = palette.grey1 }
    custom_everforest.visual.b = { bg = palette.bg1, fg = palette.grey1 }
    custom_everforest.command.b = { bg = palette.bg1, fg = palette.grey1 }
    custom_everforest.terminal.b = { bg = palette.bg1, fg = palette.grey1 }
    custom_everforest.normal.c = { bg = palette.bg1, fg = palette.grey1 }
    custom_everforest.insert.c = { bg = palette.bg1, fg = palette.grey1 }
    custom_everforest.visual.c = { bg = palette.bg1, fg = palette.grey1 }
    custom_everforest.command.c = { bg = palette.bg1, fg = palette.grey1 }
    custom_everforest.terminal.c = { bg = palette.bg1, fg = palette.grey1 }

    local branch = {
      'branch',
      icons_enabled = false,
    }
    local filename = {
      'filename',
      path = 4,
      newfile_status = true,
      padding = { left = 0, right = 0 },
    }
    local diagnostics = {
      'diagnostics',
      symbols = { error = 'E-', warn = 'W-', info = 'I-', hint = 'H-' },
    }
    local lsp = { -- TODO: see how to implement this with new Nvim 0.10
      function()
        local msg = 'No LSP'
        local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
        local clients = vim.lsp.get_clients()

        if next(clients) == nil then
          return msg
        end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
          end
        end
        return msg
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
      color = { fg = '#ff9e64', gui = 'bold' },
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
      color = { gui = 'none' },
    }
    require('lualine').setup({
      options = {
        theme = custom_everforest,
        globalstatus = true,
        always_divide_middle = false,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = { 'lazy', 'mason', 'TelescopePrompt' },
      },
      sections = {
        lualine_a = { branch },
        lualine_b = { diff },
        lualine_c = { '%=', filetype, filename },
        lualine_x = { diagnostics, lsp },
        lualine_y = { lazy },
        lualine_z = { location },
      },
    })
  end,
}
