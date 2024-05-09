-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

-- Set <space> as the leader key
-- NOTE: needs to be done first
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>')
vim.keymap.set('n', '<leader>la', ':Lazy load all<cr>')
vim.keymap.set('n', '<leader>ll', ':Lazy<cr>', { silent = true })
vim.keymap.set('n', '<leader>lp', ':Lazy profile<cr>', { silent = true })
vim.keymap.set('n', '<leader>ls', ':Lazy sync<cr>', { silent = true })

require('iton.autocmds')
require('iton.keymaps')
require('iton.options')

-- [[ Plugins ]]
require('lazy').setup({ import = 'iton.plugins' }, {
  defaults = {
    lazy = true,
  },
  install = {
    colorscheme = { 'everforest' },
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
        'tutor',
        'man',
        'matchit',
        'editorconfig',
        'spellfile',
        'tohtml',
        'gzip',
        'tarPlugin',
        'zipPlugin',
      },
    },
  },
})
