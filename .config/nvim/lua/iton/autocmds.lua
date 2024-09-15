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

local lazy = require('lazy')

autocmd('VimEnter', {
  callback = function()
    local filename = vim.fn.expand('%:p')
    if vim.fn.isdirectory(filename) == 1 then
      -- Trigger plugin loading
      lazy.load({ plugins = { 'oil.nvim' } })
    end
  end,
})

local loaded_plugins = {}

local pre_plugins_to_load = {
  'guess-indent.nvim',
  'nvim-lspconfig',
  -- Add more plugins here
}

local post_plugins_to_load = {
  'nvim-treesitter',
  'gitsigns.nvim',
  -- Add more plugins here
}

local function load_plugins(plugins_to_load)
  for _, plugin in ipairs(plugins_to_load) do
    if vim.bo.filetype ~= 'oil' and not loaded_plugins[plugin] then
      lazy.load({ plugins = { plugin } })
      loaded_plugins[plugin] = true
    end
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
    load_plugins(pre_plugins_to_load)
  end,
})

autocmd('BufReadPost', {
  callback = function()
    load_plugins(post_plugins_to_load)
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
