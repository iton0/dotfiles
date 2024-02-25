-- The keymaps below are needed at startup
-- See `:help vim.keymap.set()`

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Remap for window movement
map('n', '<c-h>', '<c-w>h', opts)
map('n', '<c-j>', '<c-w>j', opts)
map('n', '<c-k>', '<c-w>k', opts)
map('n', '<c-l>', '<c-w>l', opts)
map('n', '<c-w>', '<c-w>w', opts)

-- Remap for quicker <esc> in insert mode
map('i', 'jk', '<esc>', opts)
map('i', 'kj', '<esc>', opts)

-- Remap for better scrolling
map('n', '<c-u>', '<c-u>zz', opts)
map('n', '<c-d>', '<c-d>zz', opts)

-- Remap for closing buffers
map('n', '<c-c>', ':q<cr>', opts)

-- To move line up/down
map('n', '<S-Up>', ':m .-2<CR>==', opts)
map('n', '<S-Down>', ':m .+1<CR>==', opts)
map('v', '<S-Up>', ":m '<-2<CR>gv=gv", opts)
map('v', '<S-Down>', ":m '>+1<CR>gv=gv", opts)

-- To shift line left/right
map('n', '<', '<<', opts)
map('n', '>', '>>', opts)
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)

-- To go to the beginning and the end of line
map('n', 'H', '_', opts)
map('n', 'L', '$', opts)

-- Remap Ctrl + S to perform a decrement action
vim.api.nvim_set_keymap('n', '<C-S>', '<C-X>', opts)

-- Remap to clear highlighted search results
map('n', '<esc>', '<cmd>nohlsearch<cr>', opts)

-- Remap for terminal navigation
map('t', '<esc><esc>', [[<C-\><C-n>]], opts)
map('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
map('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
map('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
map('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
map('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)

-- Remap for toggling wordcase
map({ 'n', 'v' }, 'gu', 'g~', opts)

--Remap to clear command line output
map('n', '<M-c>', '<cmd>:echo ""<cr>', opts)

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
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
end, { noremap = true, silent = true, desc = 'Toggle Terminal' })

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
end, { noremap = true, silent = true, desc = 'LSP Install' })

-- Autocommand that executes after
-- MasonToolInstall finishes. Makes
-- it easier for LSP setup
vim.api.nvim_create_autocmd('User', {
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
