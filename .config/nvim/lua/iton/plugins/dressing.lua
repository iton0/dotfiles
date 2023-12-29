return {
  -- Improve the default vim.ui interfaces
  'stevearc/dressing.nvim',
  event = 'ColorScheme',
  opts = {},

  -- To open Lazy.nvim ui
  -- not related to the
  -- dressing.nvim plugin
  vim.keymap.set(
    'n',
    '<leader>l',
    '',
    { noremap = true, silent = true, desc = 'Lazy.nvim' }
  ),
  vim.keymap.set(
    'n',
    '<leader>ls',
    ':Lazy sync <cr>',
    { noremap = true, silent = true, desc = 'Sync' }
  ),
  vim.keymap.set(
    'n',
    '<leader>ll',
    ':Lazy <cr>',
    { noremap = true, silent = true, desc = 'Toggle Home' }
  ),
  vim.keymap.set(
    'n',
    '<leader>lp',
    ':Lazy profile<cr>',
    { noremap = true, silent = true, desc = 'Profile' }
  ),
}
