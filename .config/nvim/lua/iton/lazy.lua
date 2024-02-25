-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
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
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Opens Lazy.nvim Home
vim.keymap.set(
  'n',
  '<Space>l',
  ':Lazy<cr>',
  { noremap = true, silent = true, desc = 'Lazy.nvim' }
)

-- [[ Plugins ]]
require('lazy').setup({ { import = 'iton.plugins' } }, {
  defaults = {
    lazy = true,
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
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})
