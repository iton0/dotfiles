return {
  'stevearc/conform.nvim',
  cmd = 'ConformInfo',
  opts = {
    formatters_by_ft = {
      zsh = { 'beautysh' },
      sh = { 'beautysh' },
      lua = { 'stylua' },
      python = { 'black' },
      javascript = { 'prettierd' },
      html = { 'prettierd' },
      css = { 'prettierd' },
      java = { 'google-java-format' },
      typescript = { 'prettierd' },
      c = { 'clang-format' },
      cpp = { 'clang-format' },
      ['_'] = { 'trim_whitespace' },
    },
    format_on_save = { timeout_ms = 500, lsp_format = 'fallback' },
    notify_on_error = false,
  },
}
