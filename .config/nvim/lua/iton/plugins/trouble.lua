return {
  'folke/trouble.nvim',
  keys = {
    {
      '<leader>q',
      '<cmd>TroubleToggle<cr>',
      desc = 'Diagnostics list',
    },
  },
  -- dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    auto_close = true,
    icons = false,
  },
}
