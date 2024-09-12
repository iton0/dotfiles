return {
  'maxmx03/solarized.nvim',
  dev = true,
  init = function()
    require('solarized').setup({
      transparent = {
        enabled = true,
        pmenu = false,
      },
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
  end,
}
