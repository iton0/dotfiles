return {
  -- Better notification manager
  'rcarriga/nvim-notify',
  opts = {
    background_colour = '#000000',
    fps = 5,
    render = 'wrapped-compact',
    minimum_width = 1,
    stages = 'static',
    timeout = 3000,
  },
  -- To open Lazy.nvim ui
  -- not related to the
  -- dressing.nvim plugin
  vim.keymap.set(
    'n',
    '<leader>l',
    ':Lazy<cr>',
    { noremap = true, silent = true, desc = 'Lazy.nvim' }
  ),
}
