local M = require('iton.constants')
local map = M.map

return {
  -- Neovim Git Interface
  {
    'NeogitOrg/neogit',
    dependencies = 'nvim-lua/plenary.nvim',
    opts = {},
    map(
      'n',
      '<leader>gog',
      "<cmd>lua require('neogit').open({ kind = 'split_above' })<cr>",
      { desc = 'Git: [O]pen Neo[G]it' }
    ),
  },

  -- Wrapper for GitHub CLI
  {
    'pwntester/octo.nvim',
    cmd = 'Octo',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      enable_builtin = true,
      suppress_missing_scope = {
        projects_v2 = true,
      },
    },
    map('n', '<leader>goo', '<cmd>Octo<cr>', { desc = 'Git: [O]pen [O]cto' }),
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
      '<leader>gwl',
      "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>",

      { desc = 'Git: [W]orktree [L]ist' }
    ),
    map(
      'n',
      '<leader>gwa',
      "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>",
      { desc = 'Git: [W]orktree [A]dd' }
    ),
  },
}
