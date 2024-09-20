return {
  {
    'nmac427/guess-indent.nvim',
    opts = {},
  },
  {
    'kylechui/nvim-surround',
    keys = {
      { 'ys' },
      { 'cs' },
      { 'ds' },
    },
    opts = {},
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {},
  },
  {
    'mbbill/undotree',
    keys = {
      {
        '<leader>u',
        function()
          vim.cmd('UndotreeToggle')
          vim.cmd('NoNeckPain')
        end,
      },
    },
  },
}
