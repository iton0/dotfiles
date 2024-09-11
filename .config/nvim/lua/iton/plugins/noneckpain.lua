return {
  'shortcuts/no-neck-pain.nvim',
  keys = { { '<leader>n', '<cmd>NoNeckPain<cr>', desc = 'NoNeckPain.nvim' } },
  init = function()
    require('no-neck-pain').setup({
      width = 90,
      autocmds = {
        enableOnVimEnter = true,
      },
    })
  end,
}
