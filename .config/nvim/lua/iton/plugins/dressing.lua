return {
  -- Improve the default vim.ui interfaces
  'stevearc/dressing.nvim',
  keys = {
    '<leader>',
  },
  opts = {},

  -- To open Lazy.nvim ui
  -- not related to the
  -- dressing.nvim plugin
  vim.keymap.set('n', '<leader>l', '', { noremap = true, silent = true, desc = 'Lazy.nvim' }),
  vim.keymap.set('n', '<leader>ls', ':Lazy sync <cr>', { noremap = true, silent = true, desc = 'Sync' }),
  vim.keymap.set('n', '<leader>lu', ':Lazy update <cr>', { noremap = true, silent = true, desc = 'Update' }),
  vim.keymap.set('n', '<leader>li', ':Lazy install <cr>', { noremap = true, silent = true, desc = 'Install' }),
  vim.keymap.set('n', '<leader>lx', ':Lazy clean <cr>', { noremap = true, silent = true, desc = 'Clean' }),
  vim.keymap.set('n', '<leader>ll', ':Lazy <cr>', { noremap = true, silent = true, desc = 'Toggle Home' }),
  vim.keymap.set('n', '<leader>lp', ':Lazy profile<cr>', { noremap = true, silent = true, desc = 'Profile' }),
}
