return {
  'ThePrimeagen/harpoon',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
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
      '<leader>hn',
      "<cmd>lua require('harpoon.ui').nav_next()<cr>",
      desc = 'Go to next harpoon mark',
    },
    {
      '<leader>hj',
      "<cmd>lua require('harpoon.ui').nav_prev()<cr>",
      desc = 'Go to previous harpoon mark',
    },
  },
}
