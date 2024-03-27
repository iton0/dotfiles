return {
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPost',
    cond = function()
      local handle = io.popen(
        'git -C "'
          .. vim.fn.expand('%:p')
          .. '" rev-parse --is-inside-work-tree 2>/dev/null'
      )
      if handle then
        local result = handle:read('*a')
        handle:close()
        return result and result:match('true')
      end
      return false
    end,
    opts = {
      signs = {
        add = { text = ' +' },
        change = { text = ' |' },
        delete = { text = ' _' },
        topdelete = { text = ' ‾' },
        changedelete = { text = ' ~' },
        untracked = { text = ' ┆' },
      },
    },
  },

  -- Wrapper for Git worktree operations
  {
    'ThePrimeagen/git-worktree.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    opts = {},
    vim.keymap.set(
      'n',
      '<leader>st',
      "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>",
      { desc = '[S]earch Work[T]rees', noremap = true, silent = true }
    ),
    vim.keymap.set(
      'n',
      '<leader>gw',
      "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>",
      { desc = '[G]it [W]orktree Create', noremap = true, silent = true }
    ),
  },
}
