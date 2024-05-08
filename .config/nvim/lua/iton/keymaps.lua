local M = require('iton.constants')
local map = M.map

-- This file holds all core keymaps
-- Plugin-specific keymaps will be in
-- there respective files

map({ 'n', 'v' }, '<Space>', '<Nop>')

-- Remap for dealing with word wrap
vim.keymap.set(
  'n',
  'k',
  "v:count == 0 ? 'gk' : 'k'",
  { expr = true, silent = true }
)
vim.keymap.set(
  'n',
  'j',
  "v:count == 0 ? 'gj' : 'j'",
  { expr = true, silent = true }
)

-- Define the keymap for entering find and replace mode
map('n', '<C-f>', [[:%s/]], true, false, 'Find and Replace')
map('n', '<M-f>', [[:cdo s/]], true, false, 'Quickfix Find and Replace')

-- No effect to not conflict with tmux
map('n', '<c-b>', '<Nop>', true, true, 'None (to not conflict with tmux)')

-- Remap for quicker <esc> in insert mode
map('i', 'kj', '<esc>')
map('i', 'jk', '<esc>')

-- Diagnostic keymap
map(
  'n',
  'dp',
  vim.diagnostic.goto_prev,
  true,
  true,
  'Go to [D]iagnostic [P]revious message'
)
map(
  'n',
  'dn',
  vim.diagnostic.goto_next,
  true,
  true,
  'Go to [D]iagnostic [N]ext message'
)
map(
  'n',
  'do',
  vim.diagnostic.open_float,
  true,
  true,
  '[D]iagnostic [O]pen Float'
)

-- Remap for better scrolling
map('n', '<c-u>', '<c-u>zz')
map('n', '<c-d>', '<c-d>zz')

-- Remap for closing buffers
map('n', '<c-c>', ':q<cr>')

-- To move line up/down
map('n', '<S-Up>', ':m .-2<CR>==', true, true, 'Move line up')
map('n', '<S-Down>', ':m .+1<CR>==', true, true, 'Move line down')
map('v', '<S-Up>', ":m '<-2<CR>gv=gv", true, true, 'Move visual select up')
map('v', '<S-Down>', ":m '>+1<CR>gv=gv", true, true, 'Move visual select down')

-- To shift line left/right
map('n', '<', '<<')
map('n', '>', '>>')
map('v', '<', '<gv')
map('v', '>', '>gv')

-- To go to the beginning and the end of line
map('n', 'H', '_')
map('n', 'L', '$')

-- Remap to move through Quickfix list
map('n', '<leader>qn', '<cmd>cnext<cr>', true, true, '[Q]uickfix [N]ext')
map(
  'n',
  '<leader>qp',
  '<cmd>cprevious<cr>',
  true,
  true,
  '[Q]uickfix [P]revious'
)

-- Remap to clear highlighted search results
map('n', '<esc>', '<cmd>nohlsearch<cr>')

-- Keybinds to make split navigation easier
map('n', '<C-h>', '<C-w><C-h>', true, true, 'Move focus to the left window')
map('n', '<C-l>', '<C-w><C-l>', true, true, 'Move focus to the right window')
map('n', '<C-j>', '<C-w><C-j>', true, true, 'Move focus to the lower window')
map('n', '<C-k>', '<C-w><C-k>', true, true, 'Move focus to the upper window')

-- Remap for toggling wordcase
map({ 'n', 'v' }, 'gu', 'g~')

--Remap to clear command line output
map('n', '<M-c>', '<cmd>:echo ""<cr>', true, true, 'Clear Command line')
