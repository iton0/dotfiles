return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  -- See `:help lualine.txt`
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    options = {
      theme = function()
        local colors = {
          blue = '#61afef',
          green = '#98c379',
          purple = '#c678dd',
          cyan = '#56b6c2',
          red1 = '#e06c75',
          red2 = '#be5046',
          yellow = '#e5c07b',
          fg = '#abb2bf',
          bg = '#282c34',
          gray1 = '#828997',
        }

        return {
          normal = {
            a = { fg = colors.bg, bg = colors.blue, gui = 'bold' },
            b = { fg = '#d8b56d', bg = nil, gui = 'italic' },
            c = { fg = colors.fg, bg = nil },
            x = { fg = colors.fg, bg = nil },
            y = { fg = colors.fg, bg = nil, gui = 'bold' },
          },
          command = { a = { fg = colors.bg, bg = colors.yellow, gui = 'bold' } },
          insert = { a = { fg = colors.bg, bg = colors.green, gui = 'bold' } },
          visual = { a = { fg = colors.bg, bg = colors.purple, gui = 'bold' } },
          terminal = { a = { fg = colors.bg, bg = colors.cyan, gui = 'bold' } },
          replace = { a = { fg = colors.bg, bg = colors.red1, gui = 'bold' } },
          inactive = {
            a = { fg = colors.gray1, bg = colors.bg },
            b = { fg = colors.gray1, bg = colors.bg },
            c = { fg = colors.gray1, bg = nil },
          },
        }
      end,
      -- component_separators = { right = '❮' },
      component_separators = { right = '' },
    },
    sections = {
      lualine_a = {
        {
          'mode',
          fmt = function(str)
            return str:sub(1, 1)
          end,
        },
      },
      lualine_c = {
        {
          'filetype',
          padding = { left = 1, right = 0 },
          colored = true,
          icon_only = true,
        },
        {
          'filename',
          newfile_status = true,
          symbols = {
            modified = '✳️ ',
            readonly = '🔒 ',
            unnamed = '⟨No Name⟩ ',
            newfile = '✨ ',
          },
        },
      },
      lualine_x = {
        {
          'datetime',
          style = '%I:%M%p',
        },
        {
          'encoding',
          fmt = function(str)
            return string.upper(str)
          end,
        },
        { 'fileformat', padding = { left = 1, right = 2 } },
        {
          require('lazy.status').updates,
          cond = require('lazy.status').has_updates,
          color = { fg = '#ff9e64' },
        },
      },
    },
  },
}
