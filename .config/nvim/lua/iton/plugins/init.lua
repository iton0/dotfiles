-- Plugins that do not need any extra configuration
return {
  -- Detect tabstop and shiftwidth automatically
  {
    'tpope/vim-sleuth',
    event = { 'BufReadPost', 'BufNewFile' },
  },

  -- "gc" to comment visual regions/lines
  {
    'numToStr/Comment.nvim',
    opts = {},
    keys = {
      { 'gc', mode = { 'n', 'v' } },
      { 'gb', mode = { 'n', 'v' } },
    },
  },

  -- Undotree
  {
    'jiaoshijie/undotree',
    dependencies = 'nvim-lua/plenary.nvim',
    opts = {},
    vim.keymap.set(
      'n',
      '<leader>u',
      "<cmd>lua require('undotree').toggle()<cr>",
      { noremap = true, silent = true, desc = 'Undotree' }
    ),
  },
}
