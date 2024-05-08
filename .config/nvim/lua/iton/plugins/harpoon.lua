local M = require('iton.constants')
local map = M.map

return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = 'nvim-lua/plenary.nvim',
  opts = {
    settings = {
      save_on_toggle = true,
    },
  },
  map('n', '<C-m>', function()
    require('harpoon'):list():add()
  end, true, true, 'Harpoon Add'),

  map('n', '<C-n>', function()
    require('harpoon'):list():remove()
  end, true, true, 'Harpoon Remove'),

  map('n', '<leader>h', function()
    require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())
  end, true, true, 'Harpoon Menu'),

  map('n', '<C-q>', function()
    require('harpoon'):list():select(1)
  end, true, true, 'Harpoon 1'),

  map('n', '<C-w>', function()
    require('harpoon'):list():select(2)
  end, true, true, 'Harpoon 2'),

  map('n', '<C-e>', function()
    require('harpoon'):list():select(3)
  end, true, true, 'Harpoon 3'),
}
