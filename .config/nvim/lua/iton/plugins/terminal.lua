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
    '<C-T>',
    "<cmd>lua require('toggleterm').toggle()<cr>",
    { desc = 'Terminal' }
  ),
}
