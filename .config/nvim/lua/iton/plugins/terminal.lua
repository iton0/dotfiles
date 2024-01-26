-- Terminal window manager
return {
  'akinsho/toggleterm.nvim',
  version = '*',
  opts = {
    auto_scroll = false,
    autochdir = true, -- when neovim changes it current directory the terminal will change it's own when next it's opened
  },
  vim.keymap.set(
    'n',
    '<leader>t',
    "<cmd>lua require('toggleterm').toggle()<cr>",
    { desc = 'Terminal' }
  ),
}
