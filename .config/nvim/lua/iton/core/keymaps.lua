-- Keymaps for better default experience
-- Other keymaps are in their associated
-- plugin files
-- The keymaps below are needed at startup
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Remap for moving between splits
vim.keymap.set('n', '<leader>th', '<C-w>h', { noremap = true, silent = true, desc = 'Move to split on left' })
vim.keymap.set('n', '<leader>tj', '<C-w>j', { noremap = true, silent = true, desc = 'Move to split below' })
vim.keymap.set('n', '<leader>tk', '<C-w>k', { noremap = true, silent = true, desc = 'Move to split above' })
vim.keymap.set('n', '<leader>tl', '<C-w>l', { noremap = true, silent = true, desc = 'Move to split on right' })

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
