-- Neovim harpoon like plugin, but only the core bits
return {
  'MeanderingProgrammer/harpoon-core.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { '<leader>h', desc = 'Harpoon' },
    {
      '<leader>hm',
      "<cmd>lua require('harpoon-core.mark').add_file()<cr>",
      desc = 'Add mark',
    },
    {
      '<leader>hr',
      "<cmd>lua require('harpoon-core.mark').rm_file()<cr>",
      desc = 'Remove mark',
    },
    {
      '<leader>hu',
      "<cmd>:lua require('harpoon-core.ui').toggle_quick_menu()<cr>",
      desc = 'View marks',
    },
    {
      '<leader>1',
      "<cmd>lua require('harpoon-core.ui').nav_file(1)<cr>",
      desc = 'Mark 1',
    },
    {
      '<leader>2',
      "<cmd>lua require('harpoon-core.ui').nav_file(2)<cr>",
      desc = 'Mark 2',
    },
    {
      '<leader>3',
      "<cmd>lua require('harpoon-core.ui').nav_file(3)<cr>",
      desc = 'Mark 3',
    },
  },
  config = function()
    require('harpoon-core').setup({
      -- Make existing window active rather than creating a new window
      use_existing = true,
      -- Default action when opening a mark, defaults to current window
      -- Example: 'vs' will open in new vertical split, 'tabnew' will open in new tab
      default_action = nil,
      -- Set marks specific to each git branch inside git repository
      mark_branch = false,
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
    })
  end,
}
