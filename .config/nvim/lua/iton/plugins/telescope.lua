local M = require('iton.globals')
local map = M.map

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
    map('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    map('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    map('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    map('n', '<leader>sq', builtin.quickfix, { desc = '[S]earch [Q]uickfix' })
    map(
      'n',
      '<leader>sd',
      builtin.diagnostics,
      { desc = '[S]earch [D]iagnostics' }
    )
    map(
      'n',
      '<leader>ss',
      builtin.builtin,
      { desc = '[S]earch [S]elect Telescope' }
    )
    map(
      'n',
      '<leader>sw',
      builtin.grep_string,
      { desc = '[S]earch current [W]ord' }
    )
    map('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    map(
      'n',
      '<leader><leader>',
      builtin.resume,
      { desc = 'Opens the previous picker' }
    )

    -- Slightly advanced example of overriding default behavior and theme
    map('n', '<leader>sb', function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      builtin.current_buffer_fuzzy_find(
        require('telescope.themes').get_dropdown({
          winblend = 0,
          previewer = false,
        })
      )
    end, { desc = '[S]earch Current [B]uffer' })
    map('n', '<leader>s.', function()
      builtin.find_files({
        cwd = os.getenv('HOME'),
        prompt_title = 'Dotfiles',
        find_command = {
          'git',
          '--git-dir=' .. os.getenv('HOME') .. '/.dotfiles',
          'ls-tree',
          '-r',
          'HEAD',
          '--name-only',
        },
      })
    end, { desc = '[S]earch [.]Dotfiles' })
  end,
}
