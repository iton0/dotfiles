-- Terminal window manager
return {
  'akinsho/toggleterm.nvim',
  version = '*',
  opts = {
    auto_scroll = false,
    autochdir = true,
  },
  vim.keymap.set(
    'n',
    '<C-T>',
    "<cmd>lua require('toggleterm').toggle()<cr>",
    { desc = 'Terminal' }
  ),
}
