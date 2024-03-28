return {
  'rmehri01/onenord.nvim',
  lazy = false,
  priority = 1000,
  init = function()
    require('onenord').setup({
      fade_nc = true, -- Fade non-current windows, making them more distinguishable
      -- Style that is applied to various groups: see `highlight-args` for options
      styles = {
        comments = 'italic',
      },
      disable = {
        background = true,
        float_background = true,
        cursorline = true,
      },
    })
    vim.cmd.colorscheme('onenord')
    vim.cmd.highlight('MatchParen gui=underline,bold guifg=#D8DEE9')
    vim.cmd.highlight('WhichKeyFloat guibg=#2E3440')
    vim.cmd.highlight('Cursor gui=reverse')
    vim.cmd.highlight('TelescopeBorder guibg=NONE')
    vim.cmd.highlight('TelescopePromptBorder guibg=NONE')
    vim.cmd.highlight('TelescopeResultsBorder guibg=NONE')
    vim.cmd.highlight('TelescopePreviewBorder guibg=NONE')
    vim.cmd.highlight('TermCursor guifg=#2E3440 guibg=#81A1C1')
    vim.cmd.highlight('PmenuSel guibg=#434C5E guifg=NONE')
    vim.cmd.highlight('Pmenu guibg=#3B4252')
  end,
}
