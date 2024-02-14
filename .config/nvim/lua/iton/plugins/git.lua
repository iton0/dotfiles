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
    opts = {},
    vim.keymap.set(
      'n',
      '<leader>st',
      "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>",
      { desc = '[S]earch Work[T]ree', noremap = true, silent = true }
    ),
    vim.keymap.set(
      'n',
      '<leader>t',
      "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>",
      { desc = 'Worktree create', noremap = true, silent = true }
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
