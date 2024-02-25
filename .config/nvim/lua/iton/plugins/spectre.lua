return {
  -- Search and replace project-wide
  'nvim-pack/nvim-spectre',
  dependencies = 'nvim-lua/plenary.nvim',
  opts = {
    mapping = {
      ['run_replace'] = {
        map = '<leader>ra',
        cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
        desc = 'replace all',
      },
    },
  },
  vim.keymap.set(
    'n',
    '<leader>sp',
    '<cmd>lua require("spectre").toggle()<CR>',
    {
      desc = '[S][P]ectre: Search Panel',
    }
  ),
}
