return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = true,
  keys = {
    {
      '<leader>tt',
      ':ToggleTerm <CR>',
      { noremap = true, silent = true, desc = 'Toggle Terminal' },
    },
  },
}
