local M = require('iton.constants')

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
    local _highlight = vim.cmd.highlight
    _highlight('MatchParen gui=underline,bold guifg=#D8DEE9')
    _highlight('WinSeparator guifg=#81A1C1')
    _highlight('Cursor gui=reverse')
    _highlight('QuickFixLine gui=bold')
    _highlight(
      'StatusLine guifg='
        .. M.active_statusline.fg
        .. ' guibg='
        .. M.active_statusline.bg
    )
    _highlight(
      'StatusLineNC guifg='
        .. M.inactive_statusline.fg
        .. ' guibg='
        .. M.inactive_statusline.bg
    )
    _highlight('IncSearch gui=bold')
    _highlight('TelescopeBorder guibg=NONE')
    _highlight('TelescopeSelectionCaret gui=bold')
    _highlight('TelescopePromptBorder guibg=NONE')
    _highlight('TelescopeResultsBorder guibg=NONE')
    _highlight('TelescopePreviewBorder guibg=NONE')
    _highlight('Pmenu guibg=#2E3440')
  end,
}
