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

-- [[ Plugins ]]
require('lazy').setup({ import = 'iton.plugins' }, {
  defaults = {
    lazy = true,
  },
  dev = {
    path = '~/Code/neovim_dev/',
    fallback = true,
  },
  install = { colorscheme = { 'solarized' } },
  rocks = { enabled = false },
  checker = {
    enabled = true,
    notify = false,
    frequency = 604800, -- Check for updates once a week
  },
  change_detection = {
    notify = false,
  },
  ui = {
    border = 'rounded',
    icons = {
      cmd = ' ',
      config = ' ',
      event = ' ',
      ft = ' ',
      init = ' ',
      import = ' ',
      keys = ' ',
      lazy = ' ',
      loaded = '●',
      not_loaded = '○',
      runtime = ' ',
      require = ' ',
      source = ' ',
      start = ' ',
      task = '✔ ',
      list = {
        '●',
        '➜',
        '★',
        '‒',
      },
    },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        'netrwPlugin',
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
