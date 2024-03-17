local map = function(mode, keys, func, desc)
  vim.keymap.set(
    mode,
    keys,
    func,
    { noremap = true, silent = true, desc = desc }
  )
end
local autocmd = vim.api.nvim_create_autocmd

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

-- Remap for window movement
map('n', '<c-h>', '<c-w>h')
map('n', '<c-j>', '<c-w>j')
map('n', '<c-k>', '<c-w>k')
map('n', '<c-l>', '<c-w>l')
map('n', '<c-w>', '<c-w>w')

-- Remap for quicker <esc> in insert mode
map('i', 'jk', '<esc>')
map('i', 'kj', '<esc>')

-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev, 'Go to previous [D]iagnostic message')
map('n', ']d', vim.diagnostic.goto_next, 'Go to next [D]iagnostic message')
map(
  'n',
  '<leader>q',
  vim.diagnostic.setloclist,
  'Open diagnostic [Q]uickfix list'
)

-- Remap for better scrolling
map('n', '<c-u>', '<c-u>zz')
map('n', '<c-d>', '<c-d>zz')

-- Remap for closing buffers
map('n', '<c-c>', ':q<cr>')

-- To move line up/down
map('n', '<S-Up>', ':m .-2<CR>==')
map('n', '<S-Down>', ':m .+1<CR>==')
map('v', '<S-Up>', ":m '<-2<CR>gv=gv")
map('v', '<S-Down>', ":m '>+1<CR>gv=gv")

-- To shift line left/right
map('n', '<', '<<')
map('n', '>', '>>')
map('v', '<', '<gv')
map('v', '>', '>gv')

-- To go to the beginning and the end of line
map('n', 'H', '_')
map('n', 'L', '$')

-- Define the keymap for entering find and replace mode
map('n', '<M-f>', [[:%s/]], 'Find and Replace')

-- Remap Ctrl + S to perform a decrement action
map('n', '<C-S>', '<C-X>')

-- Remap to clear highlighted search results
map('n', '<esc>', '<cmd>nohlsearch<cr>')

-- Remap for terminal navigation
map('t', '<esc><esc>', [[<C-\><C-n>]])
map('t', '<C-h>', [[<Cmd>wincmd h<CR>]])
map('t', '<C-j>', [[<Cmd>wincmd j<CR>]])
map('t', '<C-k>', [[<Cmd>wincmd k<CR>]])
map('t', '<C-l>', [[<Cmd>wincmd l<CR>]])
map('t', '<C-w>', [[<C-\><C-n><C-w>]])

-- Remap for toggling wordcase
map({ 'n', 'v' }, 'gu', 'g~')

-- Remap to open Netrw to the left with a width of 25 columns
map('n', '<leader>e', ':25Lexplore<CR>', 'Netrw')

--Remap to clear command line output
map('n', '<M-c>', '<cmd>:echo ""<cr>')

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup(
    'kickstart-highlight-yank',
    { clear = true }
  ),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Toggle a Terminal
map('n', '<C-T>', function()
  vim.cmd('vsplit term://zsh')
  vim.cmd('vertical resize 40')
  vim.cmd('wincmd l') -- Move to the terminal window
  vim.cmd('startinsert')
end, 'Toggle Terminal')

-- Opens Lazy.nvim Home
map('n', '<Space>l', ':Lazy<cr>', 'Lazy.nvim')

-- Check if LSP server is ready. If not, starts LSP or installs LSP.
map('n', '<M-l>', function()
  if vim.lsp.buf.server_ready() then
    print(' LSP Already Installed')
    vim.defer_fn(function()
      vim.cmd('echo ""')
    end, 1000)
  else
    vim.cmd('LspStart')
    vim.defer_fn(function()
      if vim.lsp.buf.server_ready() then
        vim.cmd('echo ""')
      else
        vim.cmd('MasonToolsInstall')
      end
    end, 500)
  end
end, 'LSP Install')

-- Autocommand that executes after
-- MasonToolInstall finishes. Makes
-- it easier for LSP setup
autocmd('User', {
  pattern = 'MasonToolsUpdateCompleted',
  callback = function()
    vim.schedule(function()
      vim.cmd('LspStart')
      vim.defer_fn(function()
        if vim.lsp.buf.server_ready() then
          vim.cmd('echo " LSP Installed"')
          vim.defer_fn(function()
            vim.cmd('echo ""')
          end, 1000)
        else
          vim.cmd('LspInstall')
        end
      end, 500)
    end)
  end,
})
