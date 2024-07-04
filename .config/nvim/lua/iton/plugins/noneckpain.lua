local M = require('iton.globals')

return {
  'shortcuts/no-neck-pain.nvim',
  event = M.prenew,
  keys = { { '<leader>n', '<cmd>NoNeckPain<cr>', desc = 'NoNeckPain.nvim' } },
  opts = {
    width = 90,
    autocmds = {
      enableOnVimEnter = true,
    },
    buffers = {
      wo = {
        fillchars = 'eob: ',
      },
    },
  },
}
