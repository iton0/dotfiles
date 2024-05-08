local M = require('iton.constants')
local map = M.map

return {
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPost',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '┆' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- Neovim Git Interface
  {
    'NeogitOrg/neogit',
    dependencies = 'nvim-lua/plenary.nvim',
    opts = {},
    map(
      'n',
      '<c-g>',
      "<cmd>lua require('neogit').open({ kind = 'split_above' })<cr>",
      true,
      true,
      'Neogit'
    ),
  },

  -- Wrapper for Git worktree operations
  {
    'ThePrimeagen/git-worktree.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    opts = {},
    map(
      'n',
      '<leader>st',
      "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>",
      true,
      true,
      '[S]earch Work[T]rees'
    ),
    map(
      'n',
      '<leader>gw',
      "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>",
      true,
      true,
      '[G]it [W]orktree Create'
    ),
  },
}
