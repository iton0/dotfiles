return {
  'shortcuts/no-neck-pain.nvim',
  lazy = false,
  keys = { { '<leader>n', '<cmd>NoNeckPain<cr>', desc = 'NoNeckPain.nvim' } },
  opts = {
    width = 90,
    autocmds = {
      enableOnVimEnter = true,
    },
  },
}
