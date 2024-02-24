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
    config = true,
    keys = {
      { 'gc', mode = { 'n', 'v' } },
      { 'gb', mode = { 'n', 'v' } },
    },
  },

  -- Neovim Undotree
  {
    'jiaoshijie/undotree',
    config = true,
    vim.keymap.set(
      'n',
      '<leader>u',
      "<cmd>lua require('undotree').toggle()<cr>",
      { noremap = true, silent = true, desc = 'Undotree' }
    ),
  },

  -- Lua-based substitute function as an alternative to
  -- vim's :substitute, using Lua patterns instead of Vim regex.
  {
    'chrisgrieser/nvim-alt-substitute',
    config = true,
    keys = {
      {
        '<m-f>',
        mode = { 'n', 'x' },
        ':S /',
        desc = 'AltSubstitute',
      },
    },
  },

  -- Highlight, list and search todo comments in your projects
  {
    'folke/todo-comments.nvim',
    event = 'BufReadPost',
    cmd = 'TodoTelescope',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    opts = { signs = false },
    vim.keymap.set(
      'n',
      '<leader>sd',
      '<cmd>TodoTelescope<cr>',
      { desc = '[S]earch To[D]o' }
    ),
  },
}
