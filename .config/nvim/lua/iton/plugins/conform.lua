return {
  'stevearc/conform.nvim',
  event = 'BufWritePre',
  cmd = 'ConformInfo',
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
  opts = {
    format_on_save = { timeout_ms = 500, lsp_fallback = true },
    notify_on_error = false,
    formatters_by_ft = {
      lua = { 'stylua' },
      javascript = { 'prettierd' },
      html = { 'prettierd' },
      css = { 'prettierd' },
      typescript = { 'prettierd' },
      c = { 'clang_format' },
      cpp = { 'clang_format' },
      ['_'] = { 'trim_whitespace' },
    },
  },
  vim.keymap.set(
    { 'n', 'v' },
    '<leader>t',
    '<cmd>lua require("conform").format({ lsp_fallback = true, timeout_ms = 500 })<cr>',
    { desc = 'Format' }
  ),
}
