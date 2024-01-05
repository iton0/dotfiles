-- Plugins that do not need any extra configuration
return {
  -- Git related plugins
  {
    'tpope/vim-rhubarb',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'tpope/vim-fugitive',
    },
  },

  -- Detect tabstop and shiftwidth automatically
  {
    'tpope/vim-sleuth',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      -- Diagnostic keymaps
      vim.keymap.set(
        'n',
        '[d',
        vim.diagnostic.goto_prev,
        { desc = 'Go to previous diagnostic message' }
      )
      vim.keymap.set(
        'n',
        ']d',
        vim.diagnostic.goto_next,
        { desc = 'Go to next diagnostic message' }
      )
      vim.keymap.set(
        'n',
        '<leader>e',
        vim.diagnostic.open_float,
        { desc = 'Open floating diagnostic message' }
      )
      --[[ vim.keymap.set(
        'n',
        '<leader>q',
        vim.diagnostic.setloclist,
        { desc = 'Open diagnostics list' }
      ) ]]
    end,
  },

  -- "gc" to comment visual regions/lines
  {
    'numToStr/Comment.nvim',
    event = { 'BufReadPost', 'InsertLeave' },
    config = true,
  },
}
