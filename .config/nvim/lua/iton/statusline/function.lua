local M = {}
local fn = vim.fn
local dia_s = vim.diagnostic.severity
local git_branch = require('iton.statusline.git')
local curr_background = vim.o.background
local highlights = require('iton.statusline.highlights')

M.get_git_branch = function()
  local branch = git_branch.get_branch() and '  ' .. git_branch.get_branch()
  return branch or ''
end

M.statusline_file_and_dir = function()
  local filepath = fn.expand('%:p')
  local is_directory = fn.isdirectory(filepath)
  local output

  if is_directory == 1 then
    local dirname = fn.fnamemodify(filepath, ':t')
    output = dirname
  else
    local filename = fn.fnamemodify(filepath, ':t')
    local parent_dir = fn.fnamemodify(filepath, ':h')

    local home_dir = fn.expand('~')

    if parent_dir:sub(1, #home_dir) .. filename == filepath then
      output = '~/' .. filename
    else
      local relative_parent_dir = fn.fnamemodify(parent_dir, ':t')
      output = relative_parent_dir .. '/' .. filename
    end
  end
  return output .. ' %m%h%r'
end

M.get_diagnostics = function()
  local diagnostics = ''
  local count = vim.diagnostic.count(0)

  if vim.o.background ~= curr_background then
    highlights.init()
    curr_background = vim.o.background
  end

  local error_highlight = '%#CustDiagErrorStatLine#'
  local reset_highlight = '%*'

  local errors = count[dia_s.ERROR] or 0
  if errors > 0 then
    diagnostics = diagnostics
      .. error_highlight
      .. 'E:'
      .. errors
      .. reset_highlight
      .. ' '
  end

  local warnings = count[dia_s.WARN] or 0
  if warnings > 0 then
    diagnostics = diagnostics .. 'W:' .. warnings .. ' '
  end

  local info = count[dia_s.INFO] or 0
  if info > 0 then
    diagnostics = diagnostics .. 'I:' .. info .. ' '
  end

  local hints = count[dia_s.HINT] or 0
  if hints > 0 then
    diagnostics = diagnostics .. 'H:' .. hints .. ' '
  end

  return diagnostics ~= '' and diagnostics or ''
end

M.has_lazy_updates = function()
  if require('lazy.status').has_updates then
    return require('lazy.status').updates() or ''
  end
end

M.get_location = function()
  return ' %3c ch '
end

return M
