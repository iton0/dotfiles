local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
-- See `:help vim.highlight.on_yank()`
autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Disable New Line Comment with o/O
autocmd('FileType', {
  pattern = '*',
  callback = function()
    vim.opt.formatoptions:remove({ 'o' })
  end,
})

-- Function to check and load plugins
local function load_plugins(plugins_to_load)
  for _, plugin in ipairs(plugins_to_load) do
    local success, _ = pcall(require, plugin)
    if not success then
      require('lazy').load({ plugins = { plugin } })
    end
  end
end

-- Only load oil.nvim when starting nvim in directory
autocmd('VimEnter', {
  callback = function()
    local filename = vim.fn.expand('%:p')
    if vim.fn.isdirectory(filename) == 1 then
      -- Check if the plugin is not already loaded
      if not pcall(require, 'oil') then
        -- Trigger plugin loading
        require('lazy').load({ plugins = { 'oil.nvim' } })
      end
    end
  end,
})

-- Conditionally load plugins if the filetype is not 'oil'
autocmd('BufReadPre', {
  callback = function()
    -- Check if the filetype is 'oil'
    if vim.bo.filetype ~= 'oil' then
      -- Define plugins to load
      local plugins_to_load = {
        'nvim-lspconfig',
        'guess-indent.nvim',
        -- Add more plugins here
      }

      -- Load each plugin
      load_plugins(plugins_to_load)
    end
  end,
})
autocmd('BufReadPost', {
  callback = function()
    -- Check if the filetype is 'oil'
    if vim.bo.filetype ~= 'oil' then
      -- Define plugins to load
      local plugins_to_load = {
        'nvim-treesitter',
        'gitsigns.nvim',
        'lualine.nvim',
        -- Add more plugins here
      }

      -- Load each plugin
      load_plugins(plugins_to_load)
    end
  end,
})
autocmd('BufWritePre', {
  callback = function()
    -- Check if the filetype is 'oil'
    if vim.bo.filetype ~= 'oil' then
      -- Trigger plugin loading
      require('lazy').load({ plugins = { 'conform.nvim' } })
      require('conform').format({ timeout = 500, lsp_format = 'fallback' })
    end
  end,
})

-- Set local settings for terminal buffers
autocmd('TermOpen', {
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.scrolloff = 0
  end,
})
