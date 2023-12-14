-- Terminal window manager

return {
  'akinsho/toggleterm.nvim',
  version = '*',
  keys = {
    -- To open more terminals insert a number
    -- before the keymapping
    {
      '<leader>t',
      ':ToggleTerm <CR>',
      desc = 'Toggle Terminal',
    },
  },
  opts = {
    start_in_insert = false,
    auto_scroll = false,
  },
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]]),
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]]),
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]]),
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]]),
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]]),
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]]),
}
