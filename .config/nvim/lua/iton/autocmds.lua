local autocmd = vim.api.nvim_create_autocmd

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

local function load_plugins(plugins_to_load)
  for _, plugin in ipairs(plugins_to_load) do
    local success, _ = pcall(require, plugin)
    if not success then
      require('lazy').load({ plugins = { plugin } })
    end
  end
end

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

autocmd('BufReadPre', {
  callback = function()
    if vim.bo.filetype ~= 'oil' then
      local plugins_to_load = {
        'nvim-lspconfig',
        'guess-indent.nvim',
        -- Add more plugins here
      }
      load_plugins(plugins_to_load)
    end
  end,
})

autocmd('BufReadPost', {
  callback = function()
    if vim.bo.filetype ~= 'oil' then
      local plugins_to_load = {
        'nvim-treesitter',
        'gitsigns.nvim',
        'lualine.nvim',
        -- Add more plugins here
      }
      load_plugins(plugins_to_load)
    end
  end,
})

autocmd('BufWritePre', {
  callback = function()
    if vim.bo.filetype ~= 'oil' then
      require('lazy').load({ plugins = { 'conform.nvim' } })
      require('conform').format({ timeout = 500, lsp_format = 'fallback' })
    end
  end,
})

autocmd('TermOpen', {
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.scrolloff = 0
  end,
})
