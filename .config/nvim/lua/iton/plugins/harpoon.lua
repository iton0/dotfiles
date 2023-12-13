return {
  'ThePrimeagen/harpoon',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { '<leader>h', desc = 'Harpoon' },
    {
      '<leader>hm',
      "<cmd>lua require('harpoon.mark').add_file()<cr>",
      desc = 'Mark file with harpoon',
    },
    {
      '<leader>hu',
      "<cmd>:lua require('harpoon.ui').toggle_quick_menu()<cr>",
      desc = 'View marks',
    },
    {
      '<leader>1',
      "<cmd>lua require('harpoon.ui').nav_file(1)<cr>",
      desc = 'Navigate to File 1',
    },
    {
      '<leader>2',
      "<cmd>lua require('harpoon.ui').nav_file(2)<cr>",
      desc = 'Navigate to File 2',
    },
    {
      '<leader>3',
      "<cmd>lua require('harpoon.ui').nav_file(3)<cr>",
      desc = 'Navigate to File 3',
    },
    {
      '<leader>4',
      "<cmd>lua require('harpoon.ui').nav_file(4)<cr>",
      desc = 'Navigate to File 4',
    },
  },
}
