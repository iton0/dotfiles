-- Plugins that do not need extra configuration
return {
  -- Detect tabstop and shiftwidth automatically
  {
    'nmac427/guess-indent.nvim',
    opts = {},
  },

  -- Surrounding delimiter manipulation
  {
    'kylechui/nvim-surround',
    keys = {
      { 'ys' },
      { 'cs' },
      { 'ds' },
    },
    opts = {},
  },

  -- Adds git related signs to the gutter, as well as utilities for managing changes
  {
    'lewis6991/gitsigns.nvim',
    opts = {},
  },
}
