local M = require('iton.constants')
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
    map('n', '<leader>sh', builtin.help_tags, true, true, '[S]earch [H]elp')
    map('n', '<leader>sk', builtin.keymaps, true, true, '[S]earch [K]eymaps')
    map('n', '<leader>sf', builtin.find_files, true, true, '[S]earch [F]iles')
    map(
      'n',
      '<leader>sd',
      builtin.diagnostics,
      true,
      true,
      '[S]earch [D]iagnostics'
    )
    map(
      'n',
      '<leader>ss',
      builtin.builtin,
      true,
      true,
      '[S]earch [S]elect Telescope'
    )
    map(
      'n',
      '<leader>sw',
      builtin.grep_string,
      true,
      true,
      '[S]earch current [W]ord'
    )
    map('n', '<leader>sg', builtin.live_grep, true, true, '[S]earch by [G]rep')
    map(
      'n',
      '<leader><leader>',
      builtin.buffers,
      true,
      true,
      '[ ] Find existing buffers'
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
    end, true, true, '[S]earch Current [B]uffer')
    -- Shortcut for searching your neovim configuration files
    map('n', '<leader>sn', function()
      builtin.find_files({
        cwd = vim.fn.stdpath('config'),
        prompt_title = 'Neovim Config Files',
      })
    end, true, true, '[S]earch [N]eovim files')
  end,
}
