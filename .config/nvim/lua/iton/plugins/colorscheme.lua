return {
  'olimorris/onedarkpro.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('onedarkpro').setup({
      options = {
        transparency = true,
        highlight_inactive_windows = true,
      },
    })
    vim.cmd([[colorscheme onedark]])
    -- Adjust Neovim visual elements
    vim.cmd([[highlight MatchParen gui=underline ]])
    vim.cmd([[highlight CursorLineNr gui=bold guibg=NONE guifg=#ff9e64]])
    vim.cmd([[highlight Cursor ctermbg=214 guibg=#ff9e64]])
    vim.cmd([[highlight TelescopeSelection gui=bold guibg=NONE ctermbg=NONE]])
    vim.cmd([[highlight Visual guibg=#5C6370]])
    vim.cmd([[highlight LineNr ctermfg=DarkGray guibg=NONE guifg=DarkGray]])
    vim.cmd([[highlight CursorLine guibg=NONE ctermbg=NONE]])
    vim.cmd([[highlight StatusLine guibg=NONE ctermbg=NONE]])
    vim.cmd([[highlight Normal guibg=NONE ctermbg=NONE]])
    vim.cmd([[highlight FoldColumn guibg=NONE ctermbg=NONE]])
    vim.cmd([[highlight Folded guibg=NONE guifg=NONE]])
    vim.cmd([[highlight LspDiagnosticsDefault guibg=NONE ctermbg=NONE]])
    vim.cmd([[highlight SignColumn guibg=NONE ctermbg=NONE]])
    vim.cmd([[highlight NonText guibg=NONE ctermbg=NONE]])
    vim.cmd([[highlight NormalNC guibg=NONE ctermbg=NONE]])
    vim.cmd([[highlight VertSplit gui=bold guibg=NONE ctermbg=NONE]])
  end,
}
