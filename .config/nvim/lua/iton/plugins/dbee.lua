local M = require('iton.constants')
local map = M.map

-- TODO: figure out better UI layout
return {
  'kndndrj/nvim-dbee',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  build = function()
    -- Install tries to automatically detect the install method.
    -- if it fails, try calling it with one of these parameters:
    --    "curl", "wget", "bitsadmin", "go"
    require('dbee').install()
  end,
  config = function()
    require('dbee').setup(--[[optional config]])
  end,
  map(
    'n',
    '<leader>e',
    '<cmd>lua require("dbee").toggle()<cr>',
    true,
    true,
    'DBee Toggle'
  ),
}
