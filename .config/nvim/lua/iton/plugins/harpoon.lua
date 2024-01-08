-- Neovim harpoon like plugin, but only the core bits
return {
  'MeanderingProgrammer/harpoon-core.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    -- Make existing window active rather than creating a new window
    use_existing = true,
    -- Default action when opening a mark, defaults to current window
    -- Example: 'vs' will open in new vertical split, 'tabnew' will open in new tab
    default_action = nil,
    -- Set marks specific to each git branch inside git repository
    mark_branch = true,
    -- Use the previous cursor position of marked files when opened
    use_cursor = true,
    -- Settings for popup window
    menu = {
      width = 60,
      height = 10,
    },
    -- Highlight groups to use for various components
    highlight_groups = {
      window = 'HarpoonWindow',
      border = 'HarpoonBorder',
    },
  },
  vim.keymap.set(
    'n',
    '<leader>hu',
    "<cmd>lua require('harpoon-core.ui').toggle_quick_menu()<cr>",
    { noremap = true, silent = true, desc = 'Toggle Harpoon' }
  ),
  vim.keymap.set('n', '<leader>hm', function()
    require('harpoon-core.mark').add_file()
    print('[HARPOON] MARK ADDED')
    vim.defer_fn(function()
      vim.cmd('echo ""')
    end, 1500)
  end, { noremap = true, silent = true, desc = 'Add Mark' }),
  vim.keymap.set('n', '<leader>hr', function()
    require('harpoon-core.mark').rm_file()
    print('[HARPOON] MARK REMOVED')
    vim.defer_fn(function()
      vim.cmd('echo ""')
    end, 1500)
  end, { noremap = true, silent = true, desc = 'Remove Mark' }),
  vim.keymap.set(
    'n',
    '<c-h>',
    "<cmd>lua require('harpoon-core.ui').nav_next()<cr>",
    { noremap = true, silent = true, desc = 'Toggle Harpoon' }
  ),
  vim.keymap.set(
    'n',
    '<leader>3',
    "<cmd>lua require('harpoon-core.ui').nav_file(3)<cr>",
    { noremap = true, silent = true, desc = 'Mark 3' }
  ),
  vim.keymap.set(
    'n',
    '<leader>2',
    "<cmd>lua require('harpoon-core.ui').nav_file(2)<cr>",
    { noremap = true, silent = true, desc = 'Mark 2' }
  ),
  vim.keymap.set(
    'n',
    '<leader>1',
    "<cmd>lua require('harpoon-core.ui').nav_file(1)<cr>",
    { noremap = true, silent = true, desc = 'Mark 1' }
  ),
}
