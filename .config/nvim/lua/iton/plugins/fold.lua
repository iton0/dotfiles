return {
  'kevinhwang91/nvim-ufo',
  dependencies = { 'kevinhwang91/promise-async' },
  config = function()
    vim.api.nvim_set_option('foldmethod', 'expr')
    vim.api.nvim_set_option('foldexpr', 'nvim_treesitter#foldexpr()')
    vim.api.nvim_set_option('foldtext', 'v:lua.MyFoldText()')

    function MyFoldText()
      local line = vim.fn.getline(vim.v.foldstart)
      return '' .. line
    end

    vim.api.nvim_set_var('MyFoldText', MyFoldText)

    vim.keymap.set('n', '<CR>', ':normal! za<CR>', { noremap = true, silent = true, desc = 'Toggle Fold' })
  end,
}
