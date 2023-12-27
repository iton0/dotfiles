return {
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { '<leader>f', desc = 'File Explorer' },
  },
  config = function()
    local nvimtree = require('nvim-tree')

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- change color for arrows in tree to light blue
    vim.cmd([[ highlight NvimTreeNormal guibg=NONE ]])
    vim.cmd([[ highlight NvimTreeNormalFloat guibg=NONE ]])
    vim.cmd([[ highlight NvimTreeNormalNC guibg=NONE ]])
    vim.cmd([[ highlight NvimTreeWinSeparator guibg=NONE ]])
    vim.cmd([[ highlight NvimTreeEndOfBuffer guibg=NONE ]])
    vim.cmd([[ highlight NvimTreeFolderArrowOpen guifg=#3FC5FF ]])
    vim.cmd([[ highlight NvimTreeFolderArrowClosed guifg=#3FC5FF ]])

    -- configure nvim-tree
    nvimtree.setup({
      view = {
        width = 35,
        relativenumber = true,
      },
      -- change folder arrow icons
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = '', -- arrow when folder is closed
              arrow_open = '', -- arrow when folder is open
            },
          },
        },
      },
      -- disable window_picker for
      -- explorer to work well with
      -- window splits
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        custom = { '.DS_Store' },
      },
      git = {
        ignore = false,
      },
    })

    -- set keymaps

    vim.keymap.set('n', '<leader>ft', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle file explorer' }) -- toggle file explorer
    vim.keymap.set(
      'n',
      '<leader>ff',
      '<cmd>NvimTreeFindFileToggle<CR>',
      { desc = 'Toggle file explorer on current file' }
    ) -- toggle file explorer on current file
    vim.keymap.set('n', '<leader>fc', '<cmd>NvimTreeCollapse<CR>', { desc = 'Collapse file explorer' }) -- collapse file explorer
    vim.keymap.set('n', '<leader>fr', '<cmd>NvimTreeRefresh<CR>', { desc = 'Refresh file explorer' }) -- refresh file explorer
  end,
}
