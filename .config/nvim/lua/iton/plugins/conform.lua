return {
  'stevearc/conform.nvim',
  event = 'BufWritePre',
  cmd = 'ConformInfo',
  opts = {
    format_on_save = { timeout_ms = 500, lsp_fallback = true },
    notify_on_error = false,
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
      ['_'] = { 'trim_whitespace' },
    },
  },
}
