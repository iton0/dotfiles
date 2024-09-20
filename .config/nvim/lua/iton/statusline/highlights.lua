local M = {}

local function get_fg_from_group(group)
  local hl = vim.api.nvim_get_hl(0, { name = group })
  return hl and hl.fg and string.format('#%06x', hl.fg) or nil
end

local function get_bg_from_group(group)
  local hl = vim.api.nvim_get_hl(0, { name = group })
  return hl and hl.bg and string.format('#%06x', hl.bg) or nil
end

M.init = function()
  return {

    vim.api.nvim_set_hl(0, 'CustDiagErrorStatLine', {
      fg = get_fg_from_group('DiagnosticError'),
      bg = get_bg_from_group('StatusLine'),
      bold = true,
    }),

    vim.api.nvim_set_hl(0, 'CustLazyStatLine', {
      fg = '#d17b00',
      bg = get_bg_from_group('StatusLine'),
      bold = true,
    }),
  }
end

return M
