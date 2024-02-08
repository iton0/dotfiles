return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  config = function()
    require('nvim-tree').setup({
      renderer = { add_trailing = true },
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
      view = {
        width = 25,
      },
    })
  end,
  vim.keymap.set(
    'n',
    '<leader>xf',
    ':NvimTreeFindFile<cr>',
    { noremap = true, silent = true, desc = 'Find File' }
  ),
  vim.keymap.set(
    'n',
    '<leader>xx',
    ':NvimTreeToggle<cr>',
    { noremap = true, silent = true, desc = 'Toggle Tree' }
  ),
}
