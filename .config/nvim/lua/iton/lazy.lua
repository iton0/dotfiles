-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    lazyrepo,
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

require('iton.options')
require('iton.autocmds')
require('iton.keymaps')

-- [[ Plugins ]]
require('lazy').setup({ import = 'iton.plugins' }, {
  defaults = {
    lazy = true,
  },
  dev = {
    path = '~/personal/neovim_dev/',
    fallback = true,
  },
  install = { colorscheme = { 'lackluster', 'default' } },
  rocks = { enabled = false }, -- Disable `luarocks` support completely
  checker = {
    enabled = true,
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
        'rplugin',
        'matchit',
        'spellfile',
        'tohtml',
        'gzip',
        'tarPlugin',
        'zipPlugin',
      },
    },
  },
})
