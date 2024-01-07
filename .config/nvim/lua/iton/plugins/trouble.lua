return {
  'folke/trouble.nvim',
  -- dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    auto_close = true,
    icons = false,
  },
  vim.keymap.set('n', '<leader>q', function()
    return require('trouble').toggle()
  end, { desc = 'Diagnostics list' }),
}
