local M = require('iton.constants')
local map = M.map

-- Plugins that do not need any extra configuration
return {
  -- Detect tabstop and shiftwidth automatically
  {
    'nmac427/guess-indent.nvim',
    event = M.postnew,
    opts = {},
  },

  -- "gc" to comment visual regions/lines
  {
    'echasnovski/mini.comment',
    opts = {},
    keys = {
      { 'gc', mode = { 'n', 'v' } },
    },
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
      true,
      true,
      'Undotree'
    ),
  },
}
