-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- [[ Plugins ]]
require('lazy').setup({ { import = 'iton.plugins' } }, {
  install = {
    colorscheme = { 'onedark' },
  },
  checker = {
    -- automatically check for plugin updates
    enabled = true,
    concurrency = 4,
    notify = false,
    frequency = 86400, -- Check for updates every 24 hours
  },
  ui = {
    border = 'rounded',
    icons = {
      -- loaded = '💃',
      -- not_loaded = '🦥',
      -- plugin = '🥡',
    },
  },
  change_detection = {
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        'tutor',
      },
    },
  },
})
