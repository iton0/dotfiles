local M = require('iton.globals')
local map = M.map

-- Function to check if inside a Git repository
local function is_git_repo()
  vim.fn.system('git rev-parse --is-inside-work-tree')
  return vim.v.shell_error == 0
end

-- Function to get Git root directory
local function get_git_root()
  local dot_git_path = vim.fn.finddir('.git', '.;')
  return vim.fn.fnamemodify(dot_git_path, ':h')
end

-- Function to get Git-related options
local function get_git_opts()
  local opts = {}
  if is_git_repo() then
    opts.cwd = get_git_root()
  end
  return opts
end

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
    local telescope = require('telescope')
    local telescopeConfig = require('telescope.config')

    -- Clone the default Telescope configuration and customize it
    local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
    table.insert(vimgrep_arguments, '--hidden')
    table.insert(vimgrep_arguments, '--glob')
    table.insert(vimgrep_arguments, '!**/.git/*')
    table.insert(vimgrep_arguments, '--glob')
    table.insert(vimgrep_arguments, '!**/.git')
    table.insert(vimgrep_arguments, '--glob')
    table.insert(vimgrep_arguments, '!**/.gitignore')

    telescope.setup({
      defaults = {
        vimgrep_arguments = vimgrep_arguments,
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    })

    -- Enable Telescope extensions if installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    local builtin = require('telescope.builtin')

    -- Key mappings for Telescope functions
    map('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    map('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    map('n', '<leader>sq', builtin.quickfix, { desc = '[S]earch [Q]uickfix' })
    map('n', '<leader><leader>', builtin.resume, { desc = 'Opens the previous picker' })
    map('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })

    -- Cached Git status to avoid repeated system calls
    local is_inside_work_tree = {}
    local cwd = vim.fn.getcwd()

    map('n', '<leader>sd', function()
      local opts = get_git_opts() -- NOTE: Create new opts to ensure 'no_sign' does not affect other mappings
      opts.no_sign = true
      builtin.diagnostics(opts)
    end, { desc = '[S]earch [D]iagnostics' })

    map('n', '<leader>sw', function()
      builtin.grep_string(get_git_opts())
    end, { desc = '[S]earch current [W]ord' })

    map('n', '<leader>sg', function()
      builtin.live_grep(get_git_opts())
    end, { desc = '[S]earch by [G]rep' })

    map('n', '<leader>sf', function()
      if is_inside_work_tree[cwd] == nil then
        vim.fn.system('git rev-parse --is-inside-work-tree')
        is_inside_work_tree[cwd] = vim.v.shell_error == 0
      end

      if is_inside_work_tree[cwd] then
        builtin.git_files()
      else
        builtin.find_files()
      end
    end, { desc = '[S]earch [F]iles' })

    map('n', '<leader>sb', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
        winblend = 0,
        previewer = false,
      }))
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
