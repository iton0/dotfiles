return {
  'windwp/nvim-autopairs',
  event = 'LspAttach',
  -- Optional dependency
  dependencies = { 'hrsh7th/nvim-cmp' },
  config = function()
    require('nvim-autopairs').setup({})
    -- Disable autopairs mapping for Backspace
    vim.g.AutoPairsShortcutBackInsert = 0
    -- If you want to automatically add `(` after selecting a function or method
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end,
}
