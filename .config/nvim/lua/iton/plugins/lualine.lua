return {
  'nvim-lualine/lualine.nvim',
  event = 'BufNewFile',
  config = function()
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
    local lazy = {
      require('lazy.status').updates,
      cond = require('lazy.status').has_updates,
      color = { fg = '#d17b00', gui = 'bold' },
      padding = { left = 1, right = 1 },
    }
    local location = {
      'location',
      left_padding = 2,
      color = { gui = 'bold' },
    }
    require('lualine').setup({
      options = {
        globalstatus = true,
        always_divide_middle = false,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = { 'lazy', 'mason', 'TelescopePrompt' },
      },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { branch, '%=', filename },
        lualine_x = { diagnostics, lazy, location },
        lualine_y = {},
        lualine_z = {},
      },
    })
  end,
}
