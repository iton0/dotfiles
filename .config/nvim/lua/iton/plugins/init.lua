-- Plugins that do not need any extra configuration
return {
  -- Detect tabstop and shiftwidth automatically
  {
    'tpope/vim-sleuth',
    event = { 'BufReadPost', 'BufNewFile' },
  },

  -- "gc" to comment visual regions/lines
  {
    'numToStr/Comment.nvim',
    config = true,
    keys = {
      { 'gc', mode = { 'n', 'v' } },
      { 'gb', mode = { 'n', 'v' } },
    },
  },

  -- Neovim Undotree
  {
    'jiaoshijie/undotree',
    dependencies = 'nvim-lua/plenary.nvim',
    config = true,
    vim.keymap.set(
      'n',
      '<leader>u',
      "<cmd>lua require('undotree').toggle()<cr>",
      { noremap = true, silent = true, desc = 'Undotree' }
    ),
  },

  -- Smooth Scrolling
  {
    'karb94/neoscroll.nvim',
    keys = {
      { '<c-u>' },
      { '<c-d>' },
    },
    config = true,
  },

  -- Lua-based substitute function as an alternative to
  -- vim's :substitute, using Lua patterns instead of Vim regex.
  {
    'chrisgrieser/nvim-alt-substitute',
    config = true,
    keys = {
      {
        '<m-f>',
        mode = { 'n', 'x' },
        ':S /',
        { desc = 'AltSubstitute' },
      },
    },
  },

  -- Search panel for Neovim (can go across files)
  {
    'nvim-pack/nvim-spectre',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
    vim.keymap.set(
      'v',
      '<leader>o',
      '<esc><cmd>lua require("spectre").open_visual()<CR>',
      {
        desc = 'Search current word',
      }
    ),
    vim.keymap.set(
      'n',
      '<leader>o',
      '<cmd> lua require("spectre").toggle()<CR>',
      {
        desc = 'Spectre',
      }
    ),
  },

  -- Highlight, list and search todo comments in your projects
  {
    'folke/todo-comments.nvim',
    event = 'BufReadPost',
    cmd = 'TodoTelescope',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    opts = {},
    vim.keymap.set(
      'n',
      '<leader>sc',
      '<cmd>TodoTelescope<cr>',
      { desc = '[S]earch [C]omments' }
    ),
  },

  -- Markdown previewer
  {
    'iamcco/markdown-preview.nvim',
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
    vim.keymap.set(
      'n',
      '<leader>m',
      '<cmd>MarkdownPreviewToggle<cr>',
      { noremap = true, silent = true, desc = 'Markdown Previewer' }
    ),
  },
}
