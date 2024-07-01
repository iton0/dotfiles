local M = require('iton.globals')
local noremap_silent = M.noremap_silent

local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
-- See `:help vim.highlight.on_yank()`
autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup(
    'kickstart-highlight-yank',
    { clear = true }
  ),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Better initial navigation when using netrw
autocmd('FileType', {
  callback = function()
    if vim.bo.filetype == 'netrw' then
      vim.api.nvim_buf_set_keymap(
        0,
        'n',
        '<C-l>',
        ':wincmd l<CR>',
        noremap_silent
      )
    end
  end,
})

-- Set local settings for terminal buffers
autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('custom-term-open', {}),
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.scrolloff = 0
  end,
})
