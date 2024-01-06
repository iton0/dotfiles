-- Terminal window manager

return {
  'akinsho/toggleterm.nvim',
  version = '*',
  keys = {
    -- To open more terminals insert a number
    -- before the keymapping
    {
      '<leader>t',
      '<cmd>ToggleTerm<CR>',
      desc = 'Terminal',
    },
  },
  opts = {
    auto_scroll = false,
    autochdir = true, -- when neovim changes it current directory the terminal will change it's own when next it's opened
  },
}
