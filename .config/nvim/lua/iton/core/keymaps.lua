-- Keymaps for better default experience
-- Other keymaps are in their associated
-- plugin files
-- The keymaps below are needed at startup
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Remap for window movement
vim.keymap.set('n', '<c-h>', '<c-w>h', { noremap = true, silent = true, desc = 'Go to left window' })
vim.keymap.set('n', '<c-j>', '<c-w>j', { noremap = true, silent = true, desc = 'Go to down window' })
vim.keymap.set('n', '<c-k>', '<c-w>k', { noremap = true, silent = true, desc = 'Go to up window' })
vim.keymap.set('n', '<c-l>', '<c-w>l', { noremap = true, silent = true, desc = 'Go to right window' })
vim.keymap.set('n', '<c-w>', '<c-w>w', { noremap = true, silent = true, desc = 'Switch windows' })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
