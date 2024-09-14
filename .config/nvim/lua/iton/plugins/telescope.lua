local M = require('iton.utils')
local map = M.map

return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable('make') == 1
      end,
    },
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
  },
  keys = {
    { '<leader>' },
  },
  config = function()
    local telescope = require('telescope')

    telescope.setup({
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    })

    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    local builtin = require('telescope.builtin')

    map('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    map('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    map('n', '<leader>sq', builtin.quickfix, { desc = '[S]earch [Q]uickfix' })
    map('n', '<leader><leader>', builtin.resume, { desc = 'Opens the previous picker' })
    map('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    map('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    map('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    map('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    map('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    map('n', '<leader>gf', builtin.git_files, { desc = 'Search [G]it [F]iles' })

    map('n', '<leader>sb', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
        winblend = 0,
        previewer = false,
      }))
    end, { desc = '[S]earch [B]uffer' })

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
    end, { desc = '[S]earch [.](Dot)files' })
  end,
}
