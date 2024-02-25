-- Neovim harpoon like plugin, but only the core bits
return {
  'ThePrimeagen/harpoon',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    global_settings = {
      -- set marks specific to each git branch inside git repository
      mark_branch = true,
    },
  },
  vim.keymap.set(
    'n',
    '<leader>hu',
    "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
    { noremap = true, silent = true, desc = 'Toggle Harpoon' }
  ),
  vim.keymap.set('n', '<leader>hm', function()
    require('harpoon.mark').add_file()
  end, { noremap = true, silent = true, desc = 'Add Mark' }),
  vim.keymap.set('n', '<leader>hr', function()
    require('harpoon.mark').rm_file()
  end, { noremap = true, silent = true, desc = 'Remove Mark' }),
  vim.keymap.set(
    'n',
    '<c-h>',
    "<cmd>lua require('harpoon.ui').nav_next()<cr>",
    { noremap = true, silent = true, desc = 'Cycle Harpoon' }
  ),
  vim.keymap.set(
    'n',
    '<leader>3',
    "<cmd>lua require('harpoon.ui').nav_file(3)<cr>",
    { noremap = true, silent = true, desc = 'Harpoon 3' }
  ),
  vim.keymap.set(
    'n',
    '<leader>2',
    "<cmd>lua require('harpoon.ui').nav_file(2)<cr>",
    { noremap = true, silent = true, desc = 'Harpoon 2' }
  ),
  vim.keymap.set(
    'n',
    '<leader>1',
    "<cmd>lua require('harpoon.ui').nav_file(1)<cr>",
    { noremap = true, silent = true, desc = 'Harpoon 1' }
  ),
}
