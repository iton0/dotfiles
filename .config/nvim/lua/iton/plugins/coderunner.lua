return {
  -- TODO: find a better code runner plugin
  'CRAG666/code_runner.nvim',
  keys = {
    { '<leader>c' },
  },
  config = function()
    require('code_runner').setup({
      filetype = {
        typescript = 'deno run',
        rust = {
          'cd $dir &&',
          'rustc $fileName &&',
          '$dir/$fileNameWithoutExt',
        },
        javascript = 'node',
        c = {
          'cd $dir &&',
          'gcc $fileName -o $fileNameWithoutExt &&',
          './$fileNameWithoutExt',
        },
        cpp = {
          'cd $dir &&',
          'g++ $fileName -o $fileNameWithoutExt &&',
          './$fileNameWithoutExt',
        },
      },
    })
    vim.keymap.set(
      'n',
      '<leader>cc',
      ':RunCode<CR>',
      { noremap = true, silent = true, desc = 'Run Code' }
    )
    vim.keymap.set(
      'n',
      '<leader>cf',
      ':RunFile<CR>',
      { noremap = true, silent = true, desc = 'Run File' }
    )
    vim.keymap.set(
      'n',
      '<leader>cp',
      ':RunProject<CR>',
      { noremap = true, silent = true, desc = 'Run Project' }
    )
    vim.keymap.set(
      'n',
      '<leader>cl',
      'RunClose<CR>',
      { noremap = true, silent = true, desc = 'Close Code Runner' }
    )
  end,
}
