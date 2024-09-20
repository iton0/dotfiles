local autocmd = require('iton.utils').autocmd

autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

autocmd('FileType', {
  pattern = '*',
  callback = function()
    vim.opt.formatoptions:remove({ 'o' })
  end,
})

autocmd('TermOpen', {
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.scrolloff = 0
  end,
})

local filename = vim.fn.expand('%:p')
local lazy = require('lazy')

autocmd('UIEnter', {
  callback = function()
    if vim.fn.isdirectory(filename) == 1 then
      lazy.load({ plugins = { 'oil.nvim' } })
    end
  end,
})

local loaded_plugins = {}

local buf_pre_plugins = {
  'guess-indent.nvim',
  'nvim-lspconfig',
  -- Add more plugins here
}

local buf_post_plugins = {
  'nvim-treesitter',
  'gitsigns.nvim',
  -- Add more plugins here
}

local function load_plugins(plugins_to_load)
  if not loaded_plugins[plugins_to_load] and vim.bo.filetype ~= 'oil' then
    lazy.load({ plugins = plugins_to_load })
    loaded_plugins[plugins_to_load] = true
  end
end

autocmd('BufWritePre', {
  callback = function()
    if not loaded_plugins['conform.nvim'] and vim.bo.filetype ~= 'oil' then
      lazy.load({ plugins = { 'conform.nvim' } })
      require('conform').format({ timeout = 500, lsp_format = 'fallback' })
      loaded_plugins['conform.nvim'] = true
    end
  end,
})

autocmd('BufReadPre', {
  callback = function()
    load_plugins(buf_pre_plugins)
  end,
})

autocmd('BufReadPost', {
  callback = function()
    load_plugins(buf_post_plugins)
  end,
})

-- [[ why does this not work properly on first InsertEnter? ]]
-- [[ (works on second InsertEnter) ]]
-- autocmd('InsertEnter', {
--   callback = function()
--     if vim.bo.filetype ~= 'oil' and vim.bo.filetype ~= 'TelescopePrompt' and not loaded_plugins['nvim-cmp'] then
--       lazy.load({ plugins = { 'nvim-cmp' } })
--       loaded_plugins['nvim-cmp'] = true
--     end
--   end,
-- })
