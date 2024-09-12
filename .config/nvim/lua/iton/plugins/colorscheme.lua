return {
  'maxmx03/solarized.nvim',
  dev = true,
  init = function()
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
    -- Set the initial colorscheme
    vim.cmd.colorscheme('solarized')

    -- Function to toggle background
    local function toggle_background()
      if vim.o.background == 'dark' then
        vim.o.background = 'light'
      else
        vim.o.background = 'dark'
      end
      vim.cmd.colorscheme('solarized') -- Reload colorscheme to apply the new background
    end

    -- Set keymap to toggle background
    vim.keymap.set('n', '<M-t>', toggle_background)
  end,
}
