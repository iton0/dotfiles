-- autoformat.lua should cover
-- the rest of the file types

return {
  'stevearc/conform.nvim',
  event = 'BufWritePre',
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format({
          lsp_fallback = true,
          asyc = false,
          timeout_ms = 500,
        })
      end,
      { 'n', 'v' },
      desc = 'Format',
    },
  },
  cmd = 'ConformInfo',
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      javascript = { 'prettierd' },
      html = { 'prettierd' },
      css = { 'prettierd' },
      typescript = { 'prettierd' },
      c = { 'clang_format' },
      cpp = { 'clang_format' },
      java = { 'google-java-format' },
      -- TODO: decide if i keep this setting of not for all the files
      -- Use the "*" filetype to run formatters on all filetypes.
      -- ['*'] = { 'codespell' },
      -- Use the "_" filetype to run formatters on filetypes that don't
      -- have other formatters configured.
      ['_'] = { 'trim_whitespace' },
      php = { 'phpcbf' },
      sql = { 'sqlfluff' },
    },
    format_on_save = { timeout_ms = 500, lsp_fallback = true },
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
