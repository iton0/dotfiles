return {
  'mfussenegger/nvim-lint',
  event = 'LspAttach',
  config = function()
    local lint = require('lint')

    lint.linters_by_ft = {
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
      css = { 'stylelint' },
      php = { 'phpstan' },
      java = { 'checkstyle' },
      c = { 'cpplint' },
      cpp = { 'cpplint' },
    }

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePre', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
