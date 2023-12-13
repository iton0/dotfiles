return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = true,
  keys = {
    {
      '<leader>t',
      ':ToggleTerm <CR>',
      { noremap = true, silent = true, desc = 'Toggle Terminal' },
    },
  },
}
