return {
  'nvim-pack/nvim-spectre',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    is_block_ui_break = true,
  },
  vim.keymap.set(
    'v',
    '<leader>o',
    '<esc><cmd>lua require("spectre").open_visual()<CR>',
    {
      desc = 'Search current word',
    }
  ),
  vim.keymap.set(
    'n',
    '<leader>o',
    '<cmd> lua require("spectre").toggle()<CR>',
    {
      desc = 'Toggle Spectre',
    }
  ),
}
