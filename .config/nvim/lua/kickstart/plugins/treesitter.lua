return {
  -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  event = 'BufReadPre',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  build = ':TSUpdate',
}
