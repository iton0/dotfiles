return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  config = function()
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
      diagnostics_color = {
        warn = 'lualine_c_normal',
        info = 'lualine_c_normal',
        hint = 'lualine_c_normal',
      },
      icons_enabled = false,
      padding = { left = 0, right = 1 },
    }
    local lazy = {
      require('lazy.status').updates,
      cond = require('lazy.status').has_updates,
      color = { fg = '#d17b00', gui = 'bold' },
      padding = { left = 1, right = 1 },
    }
    local function location()
      return '%3c:%-4l'
    end
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
