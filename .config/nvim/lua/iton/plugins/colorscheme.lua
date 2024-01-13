return {
  -- TODO: next time optimizing decide if
  -- to delete solarized or onedarkpro
  --
  'Tsuzat/NeoSolarized.nvim',
  -- 'olimorris/onedarkpro.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    -- require('onedarkpro').setup({
    require('NeoSolarized').setup({
      -- options = {
      -- transparency = true,
      -- highlight_inactive_windows = true,
      -- },
      enable_italics = false, -- Italics for different hightlight groups (eg. Statement, Condition, Comment, Include, etc.)
      styles = {
        -- Style to be applied to different syntax groups
        comments = { italic = false },
        keywords = { italic = false },
        functions = { bold = false },
        variables = {},
        string = { italic = false },
        underline = true, -- true/false; for global underline
        undercurl = true, -- true/false; for global undercurl
      },
    })
    vim.cmd([[colorscheme NeoSolarized]])
    -- vim.cmd([[colorscheme onedark]])
    -- Adjust Neovim visual elements
    vim.cmd([[highlight MatchParen gui=underline]])
    vim.cmd([[highlight CursorLineNr gui=bold guibg=NONE guifg=#ff9e64]])
    vim.cmd([[highlight Cursor ctermbg=214 guibg=#ff9e64]])
    vim.cmd([[highlight TelescopeSelection guibg=NONE ctermbg=NONE]])
    vim.cmd([[highlight TelescopePreviewTitle guifg=DarkGray ctermbg=NONE]])
    vim.cmd([[highlight TelescopePromptTitle guifg=DarkGray ctermbg=NONE]])
    vim.cmd([[highlight TelescopePromptCounter guifg=DarkGray ctermbg=NONE]])
    vim.cmd([[highlight TelescopeResultsTitle guifg=DarkGray ctermbg=NONE]])
    vim.cmd([[highlight LspInfoBorder guifg=DarkGray ctermbg=NONE]])
    vim.cmd([[highlight WhichKeyFloat guibg=#282c34]])
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
