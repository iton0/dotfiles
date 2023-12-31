-- Terminal window manager

return {
  'akinsho/toggleterm.nvim',
  version = '*',
  keys = {
    -- To open more terminals insert a number
    -- before the keymapping
    {
      '<leader>t',
      '<cmd>ToggleTerm <CR>',
      desc = 'Toggle Terminal',
    },
  },
  opts = {
    auto_scroll = false,
    autochdir = true, -- when neovim changes it current directory the terminal will change it's own when next it's opened
    persist_mode = false,
  },
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]]),
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]]),
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]]),
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]]),
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]]),
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]]),
}
