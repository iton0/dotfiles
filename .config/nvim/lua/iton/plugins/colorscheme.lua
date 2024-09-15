return {
  'maxmx03/solarized.nvim',
  lazy = false,
  priority = 1000,
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
      styles = {
        types = { italic = false, bold = false },
        functions = { italic = false, bold = false },
        parameters = { italic = false, bold = false },
        comments = { italic = false, bold = false },
        strings = { italic = false, bold = false },
        keywords = { italic = false, bold = false },
        variables = { italic = false, bold = false },
        constants = { italic = false, bold = false },
      },
    })
    vim.cmd.colorscheme('solarized')

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
