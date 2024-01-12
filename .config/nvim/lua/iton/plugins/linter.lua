return {
  'mfussenegger/nvim-lint',
  event = 'LspAttach',
  config = function()
    local lint = require('lint')

    lint.linters_by_ft = {
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
      css = { 'stylelint' },
      c = { 'cpplint' },
      cpp = { 'cpplint' },
      java = { 'checkstyle' },
      php = { 'phpstan' },
      sql = { 'sqlfluff' },
      ['*'] = { 'codespell' },
    }

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

    vim.api.nvim_create_autocmd({
      'CursorMoved',
      'CursorHold',
      'CursorMovedI',
      'CursorHoldI',
    }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
