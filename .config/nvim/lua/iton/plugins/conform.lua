-- autoformat.lua should cover
-- the rest of the file types

return {
  'stevearc/conform.nvim',
  event = { 'LspAttach', 'BufWritePre' },
  opts = {
    formatters_by_ft = {
      javascript = { 'prettierd' },
      typescript = { 'prettierd' },
      lua = { 'stylua' },
      java = { 'google-java-format' },
      html = { 'prettierd' },
      css = { 'prettierd' },
      cpp = { 'clang_format' },
      c = { 'clang_format' },
      php = { 'phpcbf' },
      -- Use the "*" filetype to run formatters on all filetypes.
      ['*'] = { 'codespell' },
      -- Use the "_" filetype to run formatters on filetypes that don't
      -- have other formatters configured.
      ['_'] = { 'trim_whitespace' },
    },
    format_on_save = { async = false, timeout_ms = 500, lsp_fallback = true },
    formatters = {
      shfmt = {
        prepend_args = { '-i', '2' },
      },
    },
    notify_on_error = false,
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
