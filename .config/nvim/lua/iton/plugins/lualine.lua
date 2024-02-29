return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  -- See `:help lualine.txt`
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    require('lualine').setup({
      options = {
        theme = 'onedark',
        always_divide_middle = false,
        globalstatus = true,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
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
          '%=',
          {
            'filetype',
            icon_only = true,
            padding = { left = 1, right = 0 },
          },
          {
            'filename',
            path = 3,
            newfile_status = true,
            symbols = {
              modified = '✎ ',
              readonly = '🔒',
              unnamed = '⟨No Name⟩',
              newfile = '✨',
            },
          },
        },
        lualine_x = {
          {
            function()
              local total_marks = require('harpoon.mark').get_length()

              if total_marks == 0 then
                return ''
              end

              local current_mark = '—'

              local mark_idx = require('harpoon.mark').get_current_index()
              if mark_idx ~= nil then
                current_mark = tostring(mark_idx)
              end

              return string.format('󱡅 %s/%d', current_mark, total_marks)
            end,
          },
          {
            require('lazy.status').updates,
            cond = require('lazy.status').has_updates,
            color = { fg = '#ff9e64' },
            padding = { left = 1, right = 1 },
          },
        },
      },
    })
  end,
}
