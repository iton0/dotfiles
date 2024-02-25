return {
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPost',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '|' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
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
    config = function()
      local Worktree = require('git-worktree')
      Worktree.setup({})

      local getFirstWorktreePath = function()
        -- Run git worktree list to get a list of worktrees
        local handle = io.popen('git worktree list')

        if not handle then
          print('Error opening git worktree list.')
          return nil
        end

        local result = handle:read('*a')
        local success, reason = handle:close()

        if not success then
          print('Error reading git worktree list:', reason)
          return nil
        end

        local firstPath = result:match('(%S+)')

        return firstPath
      end

      Worktree.on_tree_change(function(op, metadata)
        if op == Worktree.Operations.Create then
          local tmuxWindowName = metadata.branch
          local firstPath = getFirstWorktreePath()
          if firstPath then
            local tmuxStartingDirectory =
              firstPath:gsub('/[^/]+$', '/' .. metadata.branch)

            local tmuxCommand = 'tmux new-window -n '
              .. tmuxWindowName
              .. ' -c '
              .. tmuxStartingDirectory
            os.execute(tmuxCommand)
          else
            print('No worktrees found.')
          end
        end
      end)
    end,
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

  -- Plugin for calling LazyGit in Neovim
  {
    'kdheepak/lazygit.nvim',
    cmd = 'LazyGit',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    vim.keymap.set(
      'n',
      '<leader>gu',
      '<cmd>LazyGit<cr>',
      { noremap = true, silent = true, desc = 'Lazy[G]it [U]I' }
    ),
  },
}
