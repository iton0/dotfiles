local autocmd = require('iton.utils').autocmd
local lazy = require('lazy')
local loaded_plugins = {}

local always_plugins = {
  'solarized.nvim',
  'no-neck-pain.nvim',
  -- Add more plugins here
}
local buf_pre_plugins = {
  'nvim-lspconfig',
  'guess-indent.nvim',
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

local function load_always_plugins()
  if not loaded_plugins[always_plugins] then
    lazy.load({ plugins = always_plugins })
    vim.schedule(function()
      vim.cmd('NoNeckPain')
    end)
    loaded_plugins[always_plugins] = true
  end
end

autocmd('FileType', {
  pattern = '*',
  callback = function()
    vim.opt.formatoptions:remove({ 'o' })
  end,
})

autocmd('BufReadPre', {
  callback = function()
    load_always_plugins()
    load_plugins(buf_pre_plugins)
  end,
})

autocmd('BufReadPost', {
  callback = function()
    load_plugins(buf_post_plugins)
  end,
})

autocmd('BufNewFile', {
  callback = function()
    load_always_plugins()
    load_plugins({ buf_post_plugins[1] })
    -- NOTE: must be done because lsp config does not properly load in this autocmd
    -- makes sure that we do not load these plugins again if entering a existing file
    lazy.load({ plugins = { buf_pre_plugins[2] } })
    loaded_plugins[buf_pre_plugins] = true
  end,
})

autocmd('UIEnter', {
  callback = function()
    load_always_plugins()
    if vim.fn.isdirectory(vim.fn.expand('%:p')) == 1 then
      lazy.load({ plugins = { 'oil.nvim' } })
    end
  end,
})

autocmd('BufWritePre', {
  callback = function()
    if not loaded_plugins['conform.nvim'] and vim.bo.filetype ~= 'oil' then
      lazy.load({ plugins = { 'conform.nvim' } })
      require('conform').format({ timeout = 500, lsp_format = 'fallback' })
      loaded_plugins['conform.nvim'] = true
    end
  end,
})

-- [[ why does this not work properly on first InsertEnter? ]]
-- [[ (works on second InsertEnter) ]]
-- autocmd('InsertEnter', {
--   callback = function()
--     if
--       not loaded_plugins['nvim-cmp']
--       and vim.bo.filetype ~= 'oil'
--       and vim.bo.filetype ~= 'TelescopePrompt'
--     then
--       lazy.load({ plugins = { 'nvim-cmp' } })
--       loaded_plugins['nvim-cmp'] = true
--     end
--   end,
-- })

autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

autocmd('TermOpen', {
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.scrolloff = 0
  end,
})
