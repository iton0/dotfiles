return {
  -- Improve the default vim.ui interfaces
  'stevearc/dressing.nvim',
  opts = {},

  -- To open Lazy.nvim ui
  -- not related to the
  -- dressing.nvim plugin
  vim.keymap.set('n', '<leader>l', ':Lazy<CR>', { noremap = true, silent = true, desc = 'Lazy.nvim' }),
}
