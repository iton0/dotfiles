return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  -- See `:help lualine.txt`
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    local custom_fname = require('lualine.components.filename'):extend()
    local highlight = require('lualine.highlight')

    function custom_fname:init(options)
      custom_fname.super.init(self, options)
      self.status_styles = {
        saved = highlight.create_component_highlight_group(
          { gui = nil }, -- Set style for saved
          'filename_status_saved',
          self.options
        ),
        modified = highlight.create_component_highlight_group(
          { gui = 'bold' }, -- Set style for modified
          'filename_status_modified',
          self.options
        ),
      }
    end

    function custom_fname:update_status()
      local data = custom_fname.super.update_status(self)
      data = highlight.component_format_highlight(
        vim.bo.modified and self.status_styles.modified
        or self.status_styles.saved
      ) .. data
      return data
    end

    require('lualine').setup({
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
              b = { fg = '#d8b56d', bg = nil },
              c = { fg = colors.fg, bg = nil },
              x = { fg = colors.fg, bg = nil },
              y = { fg = colors.fg, bg = colors.bg, gui = 'bold' },
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
        component_separators = { left = '', right = ' ' },
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
            custom_fname,
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
            'encoding',
            fmt = string.upper,
            padding = { left = 0, right = 0 },
          },
          {
            'fileformat',
            padding = { left = 0, right = 1 },
            icons_enabled = true,
            symbols = {
              unix = 'LF',
              dos = 'CRLF',
              mac = 'CR',
            },
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
            color = { fg = '#9CDC7C' },
            padding = { right = 1, left = 0 },
          },
          {
            require('lazy.status').updates,
            cond = require('lazy.status').has_updates,
            color = { fg = '#ff9e64' },
            padding = { left = 0, right = 1 },
          },
        },
        lualine_y = {
          {
            'datetime',
            style = '%I:%M%p',
            color = { fg = '#CCCCCC' },
          },
        },
      },
    })
  end,
}
