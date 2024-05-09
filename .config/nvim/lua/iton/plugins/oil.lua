local M = require('iton.globals')
local map = M.map

return {
  'stevearc/oil.nvim',
  opts = {
    -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
    -- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
    -- Additionally, if it is a string that matches "actions.<name>",
    -- it will use the mapping at require("oil.actions").<name>
    -- Set to `false` to remove a keymap
    -- See :help oil-actions for a list of all available actions
    keymaps = {
      ['<C-h>'] = false,
      ['<C-l>'] = false,
    },
    view_options = {
      -- Show files and directories that start with "."
      show_hidden = true,
    },
  },
  map('n', '-', '<cmd>lua require("oil").open()<CR>'),
  -- Open parent directory in floating window
  map('n', '<leader>-', '<cmd> lua require("oil").toggle_float()<cr>'),
}
