-- autoformat.lua should cover
-- the rest of the file types

return {
  'stevearc/conform.nvim',
  event = 'BufWritePre',
  cmd = 'ConformInfo',
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
  opts = {
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
    format_on_save = { timeout_ms = 500, lsp_fallback = true },
    formatters = {
      shfmt = {
        prepend_args = { '-i', '2' },
      },
    },
    notify_on_error = false,
  },
  vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
    require('conform').format({
      lsp_fallback = false,
      async = false,
      timeout_ms = 500,
    })
  end, { desc = 'Format' }),
}
