local M = require('iton.globals')

return {
  -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  event = M.prenew,
  cmd = 'TSUpdateSync',
  build = ':TSUpdateSync',
  main = 'nvim-treesitter.configs',
  opts = {
    ensure_installed = {
      'bash',
      'c',
      'diff',
      'html',
      'lua',
      'luadoc',
      'query',
      'markdown',
      'markdown_inline',
      'vim',
      'vimdoc',
    },
    sync_install = true,
    auto_install = true,
    highlight = {
      enable = true,
      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      --  If you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } },
  },
}
