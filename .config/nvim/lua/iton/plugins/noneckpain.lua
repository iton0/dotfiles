local M = require('iton.globals')
local map = M.map

return {
  'shortcuts/no-neck-pain.nvim',
  event = M.prenew,
  opts = {
    width = 80,
    autocmds = {
      enableOnVimEnter = true,
    },
    buffers = {
      wo = {
        fillchars = 'eob: ',
      },
    },
  },
  map('n', '<leader>n', '<cmd>NoNeckPain<cr>', { desc = 'NoNeckPain.nvim' }),
}
