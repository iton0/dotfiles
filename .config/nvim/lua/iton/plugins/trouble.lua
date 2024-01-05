return {
  'folke/trouble.nvim',
  keys = {
    {
      '<leader>q',
      '<cmd>TroubleToggle<cr>',
      desc = 'Open diagnostics list',
    },
  },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    auto_close = true,
  },
}
