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
      on_attach = function(bufnr)
        vim.keymap.set(
          'n',
          '<leader>gh',
          require('gitsigns').preview_hunk,
          { buffer = bufnr, desc = 'Preview [G]it [H]unk' }
        )

        -- don't override the built-in and fugitive keymaps
        local gs = package.loaded.gitsigns
        vim.keymap.set({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
        vim.keymap.set({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, {
          expr = true,
          buffer = bufnr,
          desc = 'Jump to previous hunk',
        })
      end,
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
      Worktree.setup({ update_on_change = false })
      -- NOTE:
      -- op = Operations.Switch, Operations.Create, Operations.Delete
      -- metadata = table of useful values (structure dependent on op)
      --      Switch
      --          path = path you switched to
      --          prev_path = previous worktree path
      --      Create
      --          path = path where worktree created
      --          branch = branch name
      --          upstream = upstream remote name
      --      Delete
      --          path = path where worktree deleted

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

        -- Extract the first worktree path
        local firstPath = result:match('(%S+)')

        return firstPath
      end

      Worktree.on_tree_change(function(op, metadata)
        if op == Worktree.Operations.Create then
          local tmuxWindowName = metadata.branch
          local firstPath = getFirstWorktreePath()
          if firstPath then
            -- Replace the last component with metadata.branch
            local tmuxStartingDirectory =
              firstPath:gsub('/[^/]+$', '/' .. metadata.branch)

            -- Create and switch to a new Tmux window
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
      Worktree.on_tree_change(function(op, metadata)
        if op == Worktree.Operations.Switch then
          local tmuxStartingDirectory = metadata.path
          local tmuxWindowName = vim.fn.fnamemodify(metadata.path, ':t')

          -- Check if a Tmux window with the same name already exists
          local existingWindow = os.execute(
            'tmux list-windows -F "#W" | grep -wq ' .. tmuxWindowName
          )

          if existingWindow ~= 0 then
            -- Tmux window with the same name does not exist, create a new one
            local tmuxCommand = 'tmux new-window -n '
              .. tmuxWindowName
              .. ' -c '
              .. tmuxStartingDirectory
            os.execute(tmuxCommand)
          else
            -- Tmux window with the same name already exists, switch to it
            os.execute('tmux select-window -t ' .. tmuxWindowName)
          end
        end
      end)
    end,
    vim.keymap.set(
      'n',
      '<leader>st',
      "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>",
      { desc = '[S]earch Work[T]ree', noremap = true, silent = true }
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
    vim.api.nvim_set_keymap(
      'n',
      '<C-g>',
      '<cmd>LazyGit<cr>',
      { noremap = true, silent = true, desc = 'LazyGit' }
    ),
  },
}
