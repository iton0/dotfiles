local M = require('iton.constants')

local autocmd = vim.api.nvim_create_autocmd

---
-- Function to check if the current filetype is in the excluded list.
--
--- @return boolean true if the current filetype is excluded; otherwise, false.
--

local function is_excluded_filetype()
  -- Retrieve the current filetype from vim
  local current_filetype = vim.bo.filetype

  -- Check if the current filetype is in the excluded set
  return M.lsp_excluded_filetypes[current_filetype] or false
end

-- Easier LSP Setup
autocmd('User', {
  pattern = 'MasonToolsUpdateCompleted',
  callback = function()
    if not is_excluded_filetype() then
      vim.cmd('LspStart')
      vim.defer_fn(function()
        if vim.lsp.buf.server_ready() then
          vim.cmd('echo "LSP(s) Installed"')
          vim.defer_fn(function()
            vim.cmd('echo ""')
          end, 3000)
        else
          vim.cmd('LspInstall')
        end
      end, 1000)
    end
  end,
})

--  This function gets run when an LSP connects to a particular buffer.
autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local map = function(keys, func, desc)
      vim.keymap.set(
        'n',
        keys,
        func,
        { buffer = event.buf, desc = 'LSP: ' .. desc }
      )
    end

    map(
      'gd',
      require('telescope.builtin').lsp_definitions,
      '[G]oto [D]efinition'
    )
    map(
      'gr',
      require('telescope.builtin').lsp_references,
      '[G]oto [R]eferences'
    )
    map(
      'gi',
      require('telescope.builtin').lsp_implementations,
      '[G]oto [I]mplementation'
    )
    map(
      'gtt',
      require('telescope.builtin').lsp_type_definitions,
      'Type [D]efinition'
    )
    map(
      '<leader>ds',
      require('telescope.builtin').lsp_document_symbols,
      '[D]ocument [S]ymbols'
    )
    map(
      '<leader>ws',
      require('telescope.builtin').lsp_dynamic_workspace_symbols,
      '[W]orkspace [S]ymbols'
    )

    map('gtd', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    -- Rename the variable under your cursor
    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

    -- Execute a code action, usually your cursor needs to be on top of an error
    -- or a suggestion from your LSP for this to activate.
    map('<leader>a', vim.lsp.buf.code_action, 'Code [A]ction')

    -- See `:help K` for why this keymap
    map('K', vim.lsp.buf.hover, 'Hover Documentation')

    -- Show the signature of the function you're currently completing.
    map('<C-s>', vim.lsp.buf.signature_help, '[S]ignature Documentation')
  end,
})

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

-- Better initial navigation when using netrw
autocmd('FileType', {
  callback = function()
    if vim.bo.filetype == 'netrw' then
      vim.cmd('map <buffer> <silent> <C-l> :wincmd l<CR>')
    end
  end,
})
