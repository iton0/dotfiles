return {
  'nvim-lualine/lualine.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
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
