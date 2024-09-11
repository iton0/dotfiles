local M = require('iton.utils')
local map = M.map

return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = 'nvim-lua/plenary.nvim',
  keys = {
    { '<leader>h' },
    { '<leader>1' },
    { '<leader>2' },
    { '<leader>3' },
    { '<leader>4' },
    { '<leader>5' },
    { '<leader>6' },
  },
  config = function()
    local harpoon = require('harpoon')
    harpoon:setup({
      settings = {
        save_on_toggle = true,
      },
    })
    map('n', '<leader>ha', function()
      require('harpoon'):list():add()
      print('Harpoon: Added')
      vim.defer_fn(function()
        vim.cmd('echo ""')
      end, 750)
    end, { desc = 'Harpoon Add' })

    map('n', '<leader>hr', function()
      require('harpoon'):list():remove()
      print('Harpoon: Removed')
      vim.defer_fn(function()
        vim.cmd('echo ""')
      end, 750)
    end, { desc = 'Harpoon Remove' })

    map('n', '<leader>hl', function()
      require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())
    end, { desc = 'Harpoon Menu' })

    for _, idx in ipairs({ 1, 2, 3, 4, 5, 6 }) do
      map('n', string.format('<space>%d', idx), function()
        require('harpoon'):list():select(idx)
      end, { desc = 'Harpoon ' .. idx })
    end
  end,
}
