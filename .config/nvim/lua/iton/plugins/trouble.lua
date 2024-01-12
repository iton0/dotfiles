return {
  'folke/trouble.nvim',
  opts = {
    auto_close = true,
    icons = false,
  },
  vim.keymap.set(
    'n',
    '<leader>q',
    "<cmd>lua require('trouble').toggle()<cr>",
    { desc = 'Trouble' }
  ),
}
