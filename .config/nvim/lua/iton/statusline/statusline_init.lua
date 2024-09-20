-- https://github.com/jiaoshijie/nvim/blob/minimal/lua/init-statusline/init.lua
local M = {}
local o = vim.o
local git_branch = require('iton.statusline.git')
local highlights = require('iton.statusline.highlights')

highlights.init()

local sections = {
  -- Left
  '%{%v:lua.require("iton.statusline.function").get_git_branch()%}',
  '%=',
  -- Middle
  '%{%v:lua.require("iton.statusline.function").statusline_file_and_dir()%}',
  '%=',
  -- Right
  '%{%v:lua.require("iton.statusline.function").get_diagnostics()%}',
  '%#CustLazyStatLine#',
  '%{%v:lua.require("iton.statusline.function").has_lazy_updates()%}',
  '%*',
  '%{%v:lua.require("iton.statusline.function").get_location()%}',
}

M.update_statusline = function()
  if
    vim.bo.filetype == 'TelescopePrompt'
    or vim.bo.filetype == 'lazy'
    or vim.bo.filetype == 'mason'
    or vim.bo.filetype == 'diff'
    or vim.bo.filetype == 'undotree'
  then
    o.laststatus = 0
    return
  end
  o.laststatus = 3
  return table.concat(sections, '')
end

local set_statusline = function()
  vim.g.qf_disable_statusline = 1
  o.statusline =
    [[%!luaeval('require("iton.statusline.statusline_init").update_statusline()')]]
end

M.setup = function()
  set_statusline()
  git_branch.init()
  vim.api.nvim_create_autocmd({
    'BufEnter',
    'BufWritePost',
    'FileChangedShellPost',
  }, {
    callback = function()
      vim.schedule(function() -- Keep UI responsive
        require('iton.statusline.statusline_init').update_statusline()
        vim.cmd('redrawstatus') -- Redraw the statusline after updating
      end)
    end,
  })
end

return M
