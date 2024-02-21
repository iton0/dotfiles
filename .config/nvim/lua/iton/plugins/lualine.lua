return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  -- See `:help lualine.txt`
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    require('lualine').setup({
      options = {
        theme = 'codedark',
        component_separators = { left = '│', right = '' },
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
            require('lazy.status').updates,
            cond = require('lazy.status').has_updates,
            color = { fg = '#ff9e64' },
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
            padding = { left = 0, right = 1 },
          },
        },
        lualine_y = { 'location' },
        lualine_z = {},
      },
    })
  end,
}
