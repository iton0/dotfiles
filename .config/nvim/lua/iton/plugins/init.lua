-- Plugins that do not need any extra configuration
return {
  -- Git related plugins
  -- {
  --   'tpope/vim-rhubarb',
  --   event = 'BufReadPost',
  --   dependencies = {
  --     'tpope/vim-fugitive',
  --   },
  -- },

  -- Detect tabstop and shiftwidth automatically
  {
    'tpope/vim-sleuth',
    event = 'BufReadPost',
  },

  -- "gc" to comment visual regions/lines
  {
    'numToStr/Comment.nvim',
    event = 'BufReadPost',
    config = true,
  },
}
