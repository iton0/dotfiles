return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  -- See `:help lualine.txt`
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    require('lualine').setup({
      options = {
        theme = function()
          local colors = {
            blue = '#268bd2',
            green = '#859900',
            purple = '#6c71c4',
            cyan = '#2aa198',
            red1 = '#dc322f',
            red2 = '#cb4b16',
            yellow = '#b58900',
            fg = '#93a1a1',
            bg = '#002b36',
            gray1 = '#657b83',
          }
          return {
            normal = {
              a = { fg = colors.bg, bg = colors.blue, gui = 'bold' },
              b = { fg = '#d8b56d', bg = nil },
              c = { fg = colors.fg, bg = nil },
              x = { fg = colors.fg, bg = nil },
              y = { fg = colors.fg, bg = nil },
            },
            command = {
              a = { fg = colors.bg, bg = colors.yellow, gui = 'bold' },
              y = { fg = colors.fg, bg = colors.bg },
            },
            insert = {
              a = { fg = colors.bg, bg = colors.green, gui = 'bold' },
              y = { fg = colors.fg, bg = colors.bg },
            },
            visual = {
              a = { fg = colors.bg, bg = colors.purple, gui = 'bold' },
              y = { fg = colors.fg, bg = colors.bg },
            },
            terminal = {
              a = { fg = colors.bg, bg = colors.cyan, gui = 'bold' },
              y = { fg = colors.fg, bg = colors.bg },
            },
            replace = {
              a = { fg = colors.bg, bg = colors.red1, gui = 'bold' },
              y = { fg = colors.fg, bg = colors.bg },
            },
            inactive = {
              a = { fg = colors.gray1, bg = colors.bg },
              b = { fg = colors.gray1, bg = colors.bg },
              c = { fg = colors.gray1, bg = colors.bg },
            },
          }
        end,
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
          {
            'filename',
            path = 4,
            newfile_status = true,
            symbols = {
              modified = '◉ ',
              readonly = '🔒 ',
              unnamed = '⟨No Name⟩ ',
              newfile = '✨ ',
            },
          },
        },
        lualine_x = {
          {
            'location',
            padding = { left = 0, right = 2 },
          },
          {
            function()
              local msg = ''
              local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
              local clients = vim.lsp.get_active_clients()
              if next(clients) == nil then
                return msg
              end
              for _, client in ipairs(clients) do
                local filetypes = client.config.filetypes
                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                  return ' ' .. client.name
                end
              end
              return msg
            end,
            padding = { left = 0, right = 2 },
          },
          {
            require('lazy.status').updates,
            cond = require('lazy.status').has_updates,
            color = { fg = '#ff9e64' },
            padding = { left = 0, right = 1 },
          },
        },
        lualine_y = {},
        lualine_z = {},
      },
    })
  end,
}
