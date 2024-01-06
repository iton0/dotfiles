-- Plugins that do not need any extra configuration
return {
  -- Git related plugins
  -- {
  --   'tpope/vim-rhubarb',
  --   event = { 'BufReadPost', 'BufNewFile' },
  --   dependencies = {
  --     'tpope/vim-fugitive',
  --   },
  -- },

  -- Detect tabstop and shiftwidth automatically
  {
    'tpope/vim-sleuth',
    event = { 'BufReadPost', 'BufNewFile' },
  },

  -- "gc" to comment visual regions/lines
  {
    'numToStr/Comment.nvim',
    event = { 'BufReadPost', 'InsertLeave' },
    config = true,
  },
}
