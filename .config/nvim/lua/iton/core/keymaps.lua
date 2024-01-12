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

--NOTE: Keeping in case trouble.nvim is trouble lol
-- remap(
--   'n',
--   '<space>q',
--   vim.diagnostic.setloclist,
--   { desc = 'Open diagnostics list' }
-- )

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

-- Set up an autocmd to handle LSP setup after reading or creating a buffer
vim.api.nvim_create_autocmd({
  'BufReadPost',
  'BufNewFile',
}, {
  pattern = '*',
  callback = function()
    vim.defer_fn(function()
      local excluded_fts = function()
        local current_buf = vim.api.nvim_get_current_buf()
        local filename = vim.fn.fnamemodify(vim.fn.bufname(current_buf), ':t')
        local current_filetype =
          vim.api.nvim_buf_get_option(current_buf, 'filetype')

        -- Excluded filetype
        -- Can either add the filetype or file extensions
        -- ex. 'text' or 'txt'
        local filetypes = {
          'php',
          'gitcommit',
          'lazy',
          'help',
          'spectre',
          'undotree',
          'TelescopePrompt',
          'gitconfig',
          'json',
          'toggleterm',
          'trouble',
          'zsh',
          'gitignore',
          'netrw',
          'text',
          'sh',
          'md',
          'rst',
          'tex',
          'pdf',
          'yaml',
          'toml',
          'cfg',
          'csv',
          'xml',
          'log',
          'out',
          'bak',
          'swp',
          'bin',
          'exe',
          'dll',
        }

        for _, filetype in ipairs(filetypes) do -- Checks filetype
          if
            current_filetype == filetype
            or current_filetype == ''
            or current_filetype == nil
          then
            return true -- Skip for excluded filetypes
          end
        end

        local patterns = {}
        for _, ext in ipairs(filetypes) do
          table.insert(patterns, string.format('.*%s$', ext))
        end

        local is_not_desired_filetype = false
        for _, pattern in ipairs(patterns) do -- Checks file extension
          if
            string.match(filename, pattern)
            or filename == ''
            or filename == nil
          then
            is_not_desired_filetype = true
            break
          end
        end

        return is_not_desired_filetype
      end
      if excluded_fts() then
        return
      else
        vim.cmd('Lazy load nvim-treesitter')
        vim.defer_fn(function()
          if vim.lsp.buf.server_ready() then
            vim.cmd('echo ""')
          else
            vim.cmd('echo ""')
            vim.cmd('LspStart')
            vim.defer_fn(function()
              if not vim.lsp.buf.server_ready() then
                vim.cmd('MasonToolsInstall')
              end
            end, 250)
          end
        end, 250)
      end
    end, 500)
  end,
})

-- Remap for easier LSP setup
remap('n', '<M-m>', function()
  if vim.lsp.buf.server_ready() then
    print(' LSP Already Installed')
    vim.defer_fn(function()
      vim.cmd('echo ""')
    end, 1000)
  else
    vim.cmd('MasonToolsInstall')
  end
end, opts)
remap('n', '<M-l>', function()
  vim.cmd('LspStart')
  vim.cmd('echo ""')
end, opts)
