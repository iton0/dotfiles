return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  -- See `:help lualine.txt`
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    options = {
      icons_enabled = true,
      theme = 'auto',
      component_separators = '',
      section_separators = '',
    },
    sections = {
      lualine_a = {
        {
          'mode',
          fmt = function(str) return str:sub(1, 1) end,
        }
      },
      lualine_c = {
        {
          "filetype",
          padding = { left = 1, right = 0 },
          colored = true,
          icon_only = true,
        },
        {
          'filename',
        },
      },
      lualine_x = {
        'fileformat',
        'encoding',
      }
    }
  },
}
