return {
  'Tsuzat/NeoSolarized.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('NeoSolarized').setup({
      enable_italics = false,
      styles = {
        -- Style to be applied to different syntax groups
        comments = { italic = false },
        keywords = { italic = false },
        functions = { bold = false },
        string = { italic = false },
      },
    })
    vim.cmd([[colorscheme NeoSolarized]])
    -- Adjust Neovim visual elements
    vim.cmd([[highlight MatchParen gui=underline guifg=WHITE]])
    vim.cmd([[highlight WhichKeyFloat guibg=#282c34]])
    vim.cmd([[highlight Visual guibg=#0d4d5a]])
  end,
}
