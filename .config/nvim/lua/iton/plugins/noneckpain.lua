local M = require('iton.constants')
local map = M.map

--TODO: figure out how to dynamically
--disable when entering filetypes below:
-- dbee, and sql
return {
  'shortcuts/no-neck-pain.nvim',
  event = M.prenew,
  opts = {
    width = 84,
    autocmds = {
      enableOnVimEnter = true,
      reloadOnColorSchemeChange = true,
    },
    buffers = {
      wo = {
        fillchars = 'eob: ',
      },
    },
  },
  map('n', '<leader>n', '<cmd>NoNeckPain<cr>', true, true, 'NoNeckPain.nvim'),
}
