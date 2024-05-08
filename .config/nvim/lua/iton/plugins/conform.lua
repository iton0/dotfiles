local M = require('iton.constants')
local map = M.map

return {
  'stevearc/conform.nvim',
  event = 'BufWritePre',
  cmd = 'ConformInfo',
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'black' },
      javascript = { 'prettierd' },
      html = { 'prettierd' },
      java = { 'google-java-format' },
      css = { 'prettierd' },
      typescript = { 'prettierd' },
      c = { 'clang-format' },
      cpp = { 'clang-format' },
      xml = { 'xmlformat' },
      ['_'] = { 'trim_whitespace' },
    },
    format_on_save = { timeout_ms = 500, lsp_fallback = true },
    notify_on_error = false,
  },
  map(
    'n',
    '<leader>f',
    '<cmd>lua require("conform").format({ async = true, lsp_fallback = true })<cr>',
    true,
    true,
    'Format buffer'
  ),
}
