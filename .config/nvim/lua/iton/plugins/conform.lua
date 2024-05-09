return {
  'stevearc/conform.nvim',
  event = 'BufWritePre',
  cmd = 'ConformInfo',
  opts = {
    formatters_by_ft = {
      zsh = { 'beautysh' },
      sh = { 'beautysh' },
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
    format_on_save = { timeout_ms = 500, lsp_fallback = true },
    notify_on_error = false,
  },
}
