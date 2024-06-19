local M = require('iton.constants')
local map = M.map

-- Plugins that do not need any extra configuration
return {
  -- Detect tabstop and shiftwidth automatically
  {
    'nmac427/guess-indent.nvim',
    event = M.prenew,
    opts = {},
  },

  -- Surrounding delimiter manipulation
  {
    'kylechui/nvim-surround',
    opts = {},
    keys = {
      { 'ys' },
      { 'cs' },
      { 'ds' },
    },
  },

  -- Undotree
  {
    'jiaoshijie/undotree',
    dependencies = 'nvim-lua/plenary.nvim',
    opts = {},
    map(
      'n',
      '<leader>u',
      "<cmd>lua require('undotree').toggle()<cr>",
      { desc = 'Undotree' }
    ),
  },

  -- Adds git related signs to the gutter, as well as utilities for managing changes
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPost',
    opts = {},
  },
}
