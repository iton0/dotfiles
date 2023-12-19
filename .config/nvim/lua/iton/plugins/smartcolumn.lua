return {
  'm4xshen/smartcolumn.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    disabled_filetypes = { 'NvimTree', 'lua', 'lazy', 'mason', 'help', 'text', 'markdown' },
  },
}
