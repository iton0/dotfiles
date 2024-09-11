-- This file holds all core keymaps
-- Plugin-specific keymaps will be in
-- their respective files

local M = require('iton.utils')
local map = M.map
local noremap_silent = M.noremap_silent
local silent = M.silent

-- Remap for Lazy.nvim functionality
map('n', '<leader>la', ':Lazy load all<cr>')
map('n', '<leader>ll', ':Lazy<cr>', silent)
map('n', '<leader>lp', ':Lazy profile<cr>', silent)
map('n', '<leader>ls', ':Lazy sync<cr>', silent)

-- Remap for dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

map('n', '<C-f>', [[:%s/]], { desc = 'Find and Replace' })
map('n', '<M-f>', [[:cdo s/]], { desc = 'Quickfix Find and Replace' })

map('n', '<c-b>', '<Nop>', { desc = 'None (to not conflict with wezterm)' })

-- Remap for quicker <esc> in insert mode
map('i', 'kj', '<esc>')
map('i', 'jk', '<esc>')

map('n', 'dp', vim.diagnostic.goto_prev, { desc = 'Go to [D]iagnostic [P]revious message' })
map('n', 'dn', vim.diagnostic.goto_next, { desc = 'Go to [D]iagnostic [N]ext message' })
map('n', 'do', vim.diagnostic.open_float, { desc = '[D]iagnostic [O]pen Float' })

-- Remap for better scrolling
map('n', '<c-u>', '<c-u>zz')
map('n', '<c-d>', '<c-d>zz')

-- Remap for closing buffers
map('n', '<c-q>', ':q<cr>', silent)

-- To move line up/down
map('n', '<S-Up>', ':m .-2<CR>==', silent)
map('n', '<S-Down>', ':m .+1<CR>==', silent)
map('v', '<S-Up>', ":m '<-2<CR>gv=gv", silent)
map('v', '<S-Down>', ":m '>+1<CR>gv=gv", silent)

-- To shift line left/right
map('n', '<', '<<')
map('n', '>', '>>')
map('v', '<', '<gv')
map('v', '>', '>gv')

-- To go to the beginning and the end of line
map('n', 'H', '_')
map('n', 'L', '$')

-- Toggle hlsearch if it's on, otherwise just do "enter"
map('n', '<CR>', function()
  if vim.opt.hlsearch:get() then
    vim.cmd.nohl()
    return ''
  else
    return vim.keycode('<CR>')
  end
end, { expr = true })

-- Quick navigation of the quickfix list
map('n', 'qn', ':cnext<CR>zz', noremap_silent)
map('n', 'qp', ':cprev<CR>zz', noremap_silent)
map('n', 'qo', ':botright copen<CR>', noremap_silent)
map('n', 'qc', ':cclose<CR>', noremap_silent)

-- Keybinds to make split navigation easier
map('n', '<C-h>', '<C-w><C-h>')
map('n', '<C-l>', '<C-w><C-l>')
map('n', '<C-j>', '<C-w><C-j>')
map('n', '<C-k>', '<C-w><C-k>')

-- Easily hit escape in terminal mode.
map('t', '<esc><esc>', '<c-\\><c-n>')

-- These mappings control the size of splits (height/width)
map('n', '<M-,>', '<c-w>5<')
map('n', '<M-.>', '<c-w>5>')
map('n', '<M-t>', '<C-W>+')
map('n', '<M-s>', '<C-W>-')

-- Open a terminal at the bottom of the screen with a fixed height.
map('n', '<c-t>', function()
  vim.cmd.new()
  vim.cmd.wincmd('J')
  vim.api.nvim_win_set_height(0, 10)
  vim.wo.winfixheight = true
  vim.cmd.term()
  vim.cmd.startinsert()
end)

-- Remap for toggling wordcase
map({ 'n', 'v' }, 'gu', 'g~')

map('n', '<M-c>', '<cmd>:echo ""<cr>', { desc = 'Clear Command line' })
