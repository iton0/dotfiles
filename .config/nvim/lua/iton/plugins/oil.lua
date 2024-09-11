return {
  'stevearc/oil.nvim',
  keys = {
    { '-', '<cmd>Oil<cr>', desc = 'Oil' },
    { '<leader>-', '<cmd>Oil --float<cr>', desc = 'Oil float' },
  },
  opts = {
    keymaps = {
      ['<C-h>'] = false,
      ['<C-l>'] = false,
      ['<C-t>'] = false,
    },
    view_options = {
      show_hidden = true,
    },
  },
}
