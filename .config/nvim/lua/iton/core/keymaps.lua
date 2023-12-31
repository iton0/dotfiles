-- Keymaps for better default experience
-- Other keymaps are in their associated
-- plugin files
-- The keymaps below are needed at startup
-- See `:help vim.keymap.set()`

local remap = vim.keymap.set
local opts = { noremap = true, silent = true }

remap({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
remap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
remap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Remap for window movement
remap('n', '<c-h>', '<c-w>h', opts)
remap('n', '<c-j>', '<c-w>j', opts)
remap('n', '<c-k>', '<c-w>k', opts)
remap('n', '<c-l>', '<c-w>l', opts)
remap('n', '<c-w>', '<c-w>w', opts)

-- Remap for quicker <esc> in insert mode
remap('i', 'jk', '<esc>', opts)
remap('i', 'kj', '<esc>', opts)

-- Remap for search and replace
remap('n', '<c-f>', ':%s/', { noremap = true, desc = 'Search and Replace' })

-- Remap for better scrolling
remap('n', '<c-u>', '<c-u>zz', opts)
remap('n', '<c-d>', '<c-d>zz', opts)

-- Remap for opening netrw
remap(
  'n',
  '<c-x>',
  ':vertical 25Vex<cr>',
  { noremap = true, silent = true, desc = 'NetRW' }
)
remap('n', '<c-c>', ':q<cr>', opts)

-- To move line up/down
remap('n', '<S-Up>', ':m .-2<CR>==', opts)
remap('n', '<S-Down>', ':m .+1<CR>==', opts)
remap('v', '<S-Up>', ":m '<-2<CR>gv=gv", opts)
remap('v', '<S-Down>', ":m '>+1<CR>gv=gv", opts)

-- To shift line left/right
remap('n', '<', '<<', opts)
remap('n', '>', '>>', opts)
remap('v', '<', '<gv', opts)
remap('v', '>', '>gv', opts)

-- To go to the beginning and the end of line
remap('n', 'H', '_', opts)
remap('n', 'L', '$', opts)

-- Folding configuration
-- function MyFoldText()
--   local line = vim.fn.getline(vim.v.foldstart)
--   return '🪭 ' .. line
-- end
--
-- vim.api.nvim_set_var('MyFoldText', MyFoldText)

-- Toggle folds with Enter key
-- remap('n', '<CR>', 'za', opts)

-- Remap Ctrl + S to perform a decrement action
vim.api.nvim_set_keymap('n', '<C-S>', '<C-X>', opts)

-- Opens Lazy.nvim Home
remap(
  'n',
  '<Space>l',
  ':Lazy<cr>',
  { noremap = true, silent = true, desc = 'Lazy.nvim' }
)

-- Remap for terminal navigation
remap('t', '<esc>', [[<C-\><C-n>]], opts)
remap('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
remap('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
remap('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
remap('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
remap('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)

-- Paste without affecting the default register contents
remap('v', 'p', '"_dP', opts)

-- Remap for toggling wordcase
remap('n', 'gu', 'g~', opts)
remap('v', 'gu', 'g~', opts)

-- Diagnostic Keymaps
remap('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
remap('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
remap(
  'n',
  '<space>e',
  vim.diagnostic.open_float,
  { desc = 'Floating diagnostic' }
)
-- remap(
--   'n',
--   '<space>q',
--   vim.diagnostic.setloclist,
--   { desc = 'Open diagnostics list' }
-- )

-- Remap for easier LSP setup
-- TODO: figure out how to combine these
-- 3 functions into one via sequential/async
-- execution
remap('n', '<M-l>', function()
  if vim.lsp.buf.server_ready() then
    print('Already Installed')
  else
    vim.cmd('LspInstall')
  end
end, opts)
remap('n', '<M-m>', function()
  vim.cmd('MasonToolsInstall')
end, opts)
remap('n', '<M-s>', function()
  vim.cmd('LspStart')
end, opts)

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group =
  vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
