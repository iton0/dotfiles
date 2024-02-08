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

-- Remap for better scrolling
remap('n', '<c-u>', '<c-u>zz', opts)
remap('n', '<c-d>', '<c-d>zz', opts)

-- Remap for closing buffers
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

-- Remap Ctrl + S to perform a decrement action
vim.api.nvim_set_keymap('n', '<C-S>', '<C-X>', opts)

-- Remap to clear highlighted search results
remap('n', '<esc>', '<cmd>nohlsearch<cr>', opts)

-- Remap for terminal navigation
remap('t', '<esc>', [[<C-\><C-n>]], opts)
remap('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
remap('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
remap('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
remap('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
remap('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)

-- Remap for toggling wordcase
remap({ 'n', 'v' }, 'gu', 'g~', opts)

--Remap to clear command line output
remap('n', '<M-c>', '<cmd>:echo ""<cr>', opts)

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

remap('n', '<M-l>', function()
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
