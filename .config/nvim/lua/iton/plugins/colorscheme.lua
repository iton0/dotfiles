return {
  'maxmx03/solarized.nvim',
  config = function()
    require('solarized').setup({
      transparent = {
        pmenu = false,
      },
      on_highlights = function()
        local groups = {
          SignColumn = { bg = 'NONE' },
          LineNr = { bg = 'NONE' },
          WinSeparator = { bg = 'NONE' },
          DiagnosticSignError = { bg = 'NONE' },
          DiagnosticSignHint = { bg = 'NONE' },
          DiagnosticSignWarn = { bg = 'NONE' },
          DiagnosticSignInfo = { bg = 'NONE' },
          DiagnosticSignOk = { bg = 'NONE' },
          GitSignsAdd = { bg = 'NONE' },
          GitSignsChange = { bg = 'NONE' },
          GitSignsDelete = { bg = 'NONE' },
        }
        return groups
      end,
      styles = { enabled = false },
    })

    vim.cmd.colorscheme('solarized')

    -- NOTE: only works for WSL
    vim.keymap.set('n', '<M-t>', function()
      if vim.o.background == 'dark' then
        vim.o.background = 'light'
      else
        vim.o.background = 'dark'
      end
      vim.cmd.colorscheme('solarized')
    end)
  end,
}
