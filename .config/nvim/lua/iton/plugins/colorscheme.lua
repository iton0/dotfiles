return {
  'Tsuzat/NeoSolarized.nvim',
  lazy = false,
  priority = 1000,
  init = function()
    require('NeoSolarized').setup({
      enable_italics = false,
      styles = {
        keywords = { italic = false },
        functions = { bold = false },
        string = { italic = false },
      },
    })
    vim.cmd.colorscheme('NeoSolarized')
    vim.cmd.highlight('MatchParen gui=underline,bold guifg=WHITE')
    vim.cmd.highlight('WhichKeyFloat guibg=#282c34')
    vim.cmd.highlight('Cursor gui=reverse')
    vim.cmd.highlight('TermCursor guifg=#282C34 guibg=#56B6C2')
    vim.cmd.highlight('Visual guibg=#0d4d5a')
    vim.cmd.highlight('WinSeparator guifg=#f2f2f2')
    -- Better completion menu colors
    vim.cmd.highlight('PmenuSel guibg=#2C323C guifg=NONE')
    vim.cmd.highlight('Pmenu guibg=#22252A')
  end,
}
