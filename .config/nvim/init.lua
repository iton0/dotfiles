-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- [[ Plugins ]]
require('lazy').setup({

  require 'kickstart.plugins.init',
  require 'kickstart.plugins.lsp',
  require 'kickstart.plugins.cmp',
  require 'kickstart.plugins.telescope',
  require 'kickstart.plugins.treesitter',
  require 'kickstart.plugins.theme',
  require 'kickstart.plugins.lualine',
  require 'kickstart.plugins.gitsigns',
  require 'kickstart.plugins.whichkey',
  require 'kickstart.plugins.comment',
  require 'kickstart.plugins.autoformat',
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.coderunner',
  require 'kickstart.plugins.portal',

  -- The second arguement here changes
  -- the default lazy.nvim configuration
}, {
  install = {
    colorscheme = { 'tokyonight' }
  },
  checker = {
    -- automatically check for plugin updates
    enabled = true,
    concurrency = 4,
    notify = false,
    frequency = 43200, -- Check for updates every 12 hours
  },
  change_detection = {
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      }
    }
  }
})

-- [[ Setting options ]]
require('options')

-- [[ Basic Keymaps ]]
require('keymaps')

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
