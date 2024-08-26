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

-- Only load oil.nvim when starting nvim in directory
autocmd('VimEnter', {
  pattern = '*',
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
  pattern = '*',
  callback = function()
    -- Check if the filetype is 'oil'
    if vim.bo.filetype ~= 'oil' then
      -- Define plugins to load
      local plugins_to_load = {
        'nvim-lspconfig',
        'guess-indent.nvim',
      }

      -- Load each plugin
      require('lazy').load({ plugins = plugins_to_load })
    end
  end,
})
autocmd('BufReadPost', {
  pattern = '*',
  callback = function()
    -- Check if the filetype is 'oil'
    if vim.bo.filetype ~= 'oil' then
      -- Define plugins to load
      local plugins_to_load = {
        'nvim-treesitter',
        'gitsigns.nvim',
        'lualine.nvim',
      }

      -- Load each plugin
      require('lazy').load({ plugins = plugins_to_load })
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
