local M = require('iton.constants')
local map = M.map

return {
  'nvim-neotest/neotest',

  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    -- Add your own adapters here
    -- 'rcasia/neotest-java',
    -- 'nvim-neotest/neotest-python',
  },
  config = function()
    require('neotest').setup({
      adapters = {
        -- ['neotest-java'] = {},
        -- require('neotest-python'),
      },
    })
  end,
  map('n', '<leader>tt', function()
    require('neotest').run.run()
  end),
  map('n', '<leader>tf', function()
    require('neotest').run.run(vim.fn.expand('%'))
  end),
  map('n', '<leader>ta', function()
    require('neotest').run.attach()
  end),
  map('n', '<leader>td', function()
    require('neotest').run.run({ strategy = 'dap' })
  end),
}
