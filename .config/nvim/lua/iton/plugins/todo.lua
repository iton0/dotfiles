return {
  'folke/todo-comments.nvim',
  cmd = 'TodoTelescope',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
  opts = {},
  vim.keymap.set(
    'n',
    '<leader>st',
    '<cmd>TodoTelescope<cr>',
    { desc = '[S]earch [T]odo' }
  ),
}
