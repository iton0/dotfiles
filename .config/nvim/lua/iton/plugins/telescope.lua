return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  keys = {
    { '<leader>' },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable('make') == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
  },

  config = function()
    require('telescope').setup({
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    })

    -- Enable telescope fzf native, if installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- Enable Git worktree telescope extension
    require('telescope').load_extension('git_worktree')

    local builtin = require('telescope.builtin')
    vim.keymap.set(
      'n',
      '<leader>sh',
      builtin.help_tags,
      { desc = '[S]earch [H]elp' }
    )
    vim.keymap.set(
      'n',
      '<leader>sk',
      builtin.keymaps,
      { desc = '[S]earch [K]eymaps' }
    )
    vim.keymap.set(
      'n',
      '<leader>sf',
      builtin.find_files,
      { desc = '[S]earch [F]iles' }
    )
    vim.keymap.set(
      'n',
      '<leader>sd',
      builtin.diagnostics,
      { desc = '[S]earch [D]iagnostics' }
    )
    vim.keymap.set(
      'n',
      '<leader>ss',
      builtin.builtin,
      { desc = '[S]earch [S]elect Telescope' }
    )
    vim.keymap.set(
      'n',
      '<leader>sw',
      builtin.grep_string,
      { desc = '[S]earch current [W]ord' }
    )
    vim.keymap.set(
      'n',
      '<leader>sg',
      builtin.live_grep,
      { desc = '[S]earch by [G]rep' }
    )
    vim.keymap.set(
      'n',
      '<leader><leader>',
      builtin.buffers,
      { desc = '[ ] Find existing buffers' }
    )

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>sb', function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      builtin.current_buffer_fuzzy_find(
        require('telescope.themes').get_dropdown({
          winblend = 0,
          previewer = false,
        })
      )
    end, { desc = '[S]earch Current [B]uffer' })
    -- Shortcut for searching your neovim configuration files
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files({
        cwd = vim.fn.stdpath('config'),
        prompt_title = 'Neovim Config Files',
      })
    end, { desc = '[S]earch [N]eovim files' })
  end,
}
