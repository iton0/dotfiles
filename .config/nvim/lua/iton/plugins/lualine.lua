local M = require('iton.constants')

return {
  'nvim-lualine/lualine.nvim',
  event = M.postnew,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local mode = {
      'mode',
      fmt = function(str)
        return str:sub(1, 1)
      end,
      color = { gui = 'bold,inverse' },
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
      colored = false,
    }
    local lsp = {
      function()
        local msg = 'No LSP'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()

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
      icon = '',
      padding = { left = 0, right = 0 },
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
      padding = { left = 1, right = 0 },
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
    }
    require('lualine').setup({
      options = {
        theme = {
          normal = {
            a = {
              bg = M.active_statusline.bg,
              fg = M.active_statusline.fg,
            },
            b = { bg = M.active_statusline.bg, fg = M.active_statusline.fg },
            c = { bg = M.active_statusline.bg, fg = M.active_statusline.fg },
            z = { bg = M.active_statusline.bg, fg = M.active_statusline.fg },
          },
          insert = {
            a = {
              bg = M.active_statusline.bg,
              fg = M.active_statusline.fg,
            },
            b = { bg = M.active_statusline.bg, fg = M.active_statusline.fg },
            c = { bg = M.active_statusline.bg, fg = M.active_statusline.fg },
            z = { bg = M.active_statusline.bg, fg = M.active_statusline.fg },
          },
          visual = {
            a = {
              bg = M.active_statusline.bg,
              fg = M.active_statusline.fg,
            },
            b = { bg = M.active_statusline.bg, fg = M.active_statusline.fg },
            c = { bg = M.active_statusline.bg, fg = M.active_statusline.fg },
            z = { bg = M.active_statusline.bg, fg = M.active_statusline.fg },
          },
          replace = {
            a = {
              bg = M.active_statusline.bg,
              fg = M.active_statusline.fg,
            },
            b = { bg = M.active_statusline.bg, fg = M.active_statusline.fg },
            c = { bg = M.active_statusline.bg, fg = M.active_statusline.fg },
            z = { bg = M.active_statusline.bg, fg = M.active_statusline.fg },
          },
          command = {
            a = {
              bg = M.active_statusline.bg,
              fg = M.active_statusline.fg,
            },
            b = { bg = M.active_statusline.bg, fg = M.active_statusline.fg },
            c = { bg = M.active_statusline.bg, fg = M.active_statusline.fg },
            z = { bg = M.active_statusline.bg, fg = M.active_statusline.fg },
          },
        },
        globalstatus = true,
        always_divide_middle = false,
        component_separators = { left = '', right = '' },
        section_separators = { left = ' ', right = ' ' },
        disabled_filetypes = { 'lazy', 'mason', 'TelescopePrompt' },
      },
      sections = {
        lualine_a = { mode },
        lualine_b = { 'branch', diff },
        lualine_c = { '%=', filetype, filename },
        lualine_x = { diagnostics, lsp },
        lualine_y = { lazy },
        lualine_z = { location },
      },
    })
  end,
}
