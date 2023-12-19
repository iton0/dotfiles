return {
  'm4xshen/smartcolumn.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    disabled_filetypes = {
      'NvimTree',
      'gitcommit',
      'lua',
      'lazy',
      'mason',
      'help',
      'text',
      'markdown',
    },
  },
}
