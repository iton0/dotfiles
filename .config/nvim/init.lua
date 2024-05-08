-- Set <space> as the leader key
-- NOTE: needs to be done first
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('iton.autocmds')
require('iton.options')
require('iton.keymaps')

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    lazyrepo,
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Opens Lazy.nvim Home
vim.keymap.set(
  'n',
  '<leader>l',
  ':Lazy<cr>',
  { noremap = true, silent = true, desc = 'Lazy.nvim' }
)

-- [[ Plugins ]]
require('lazy').setup({
  spec = 'iton.plugins',
  defaults = {
    lazy = true,
  },
  install = {
    colorscheme = { 'onenord' },
  },
  checker = {
    enabled = true,
    concurrency = 4,
    notify = false,
    frequency = 86400, -- Check for updates every 24 hours
  },
  ui = {
    border = 'rounded',
  },
  change_detection = {
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})
