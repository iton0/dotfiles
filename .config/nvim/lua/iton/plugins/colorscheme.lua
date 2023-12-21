return {
  'olimorris/onedarkpro.nvim',
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    require('onedarkpro').setup({
      options = {
        transparency = true,
        highlight_inactive_windows = true,
      },
    })
    vim.cmd([[colorscheme onedark_vivid]])
    -- Adjust Neovim visual elements
    vim.cmd([[highlight CursorLineNr guibg=NONE ctermfg=Yellow guifg=#FFD700]])
    vim.cmd([[highlight LineNr ctermfg=LightGray guibg=NONE guifg=LightGray]])
    vim.cmd([[highlight CursorLine guibg=NONE ctermbg=NONE]])
    vim.cmd([[highlight StatusLine guibg=NONE ctermbg=NONE]])
    vim.cmd([[highlight Normal guibg=NONE ctermbg=NONE]])
    vim.cmd([[highlight FoldColumn guibg=NONE ctermbg=NONE]])
    vim.cmd([[highlight Folded guibg=NONE guifg=#666666]])
    vim.cmd([[highlight LspDiagnosticsDefault guibg=NONE ctermbg=NONE]])
    vim.cmd([[highlight SignColumn guibg=NONE ctermbg=NONE]])
    vim.cmd([[highlight NonText guibg=NONE ctermbg=NONE]])
    vim.cmd([[highlight NormalNC guibg=NONE ctermbg=NONE]])
    vim.cmd([[highlight VertSplit guibg=NONE ctermbg=NONE]])
  end,
}
