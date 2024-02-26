return {
  'Tsuzat/NeoSolarized.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('NeoSolarized').setup({
      enable_italics = false,
      styles = {
        comments = { italic = false },
        keywords = { italic = false },
        functions = { bold = false },
        string = { italic = false },
      },
    })
    vim.cmd.colorscheme('NeoSolarized')
    -- Adjust Neovim visual elements
    vim.cmd.highlight('MatchParen gui=standout guifg=WHITE')
    vim.cmd.highlight('WhichKeyFloat guibg=#282c34')
    -- Better highlight for Visual
    vim.cmd.highlight('Visual guibg=#0d4d5a')
    -- Better completion menu colors
    vim.cmd.highlight('PmenuSel guibg=#282C34 guifg=NONE')
    vim.cmd.highlight('Pmenu guifg=#C5CDD9 guibg=#22252A')
    -- Better window seperators for transparent mode
    vim.cmd.highlight('WinSeparator guifg=#f2f2f2')
  end,
}
