local M = require('iton.constants')
local map = M.map

-- TODO: add language specific adapters and configure
return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    -- Add your own adapters here
  },
  config = function()
    require('neotest').setup({
      adapters = {},
    })
  end,
}
