return {
  'stevearc/oil.nvim',
  keys = {
    { '-', '<cmd>Oil<cr>', desc = 'Oil' },
    { '<leader>-', '<cmd>Oil --float<cr>', desc = 'Oil float' },
  },
  opts = {
    constrain_cursor = 'name',
    keymaps = {
      ['<C-h>'] = false,
      ['<C-l>'] = false,
      ['<C-t>'] = false,
    },
    view_options = {
      natural_order = false,
      show_hidden = true,
    },
  },
}
