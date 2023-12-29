return {
  'CRAG666/code_runner.nvim',
  keys = {
    { '<leader>c' },
  },
  config = function()
    require('code_runner').setup({
      filetype = {
        java = {
          'cd $dir &&',
          'javac $fileName &&',
          'java $fileNameWithoutExt',
        },
        typescript = 'deno run',
        rust = {
          'cd $dir &&',
          'rustc $fileName &&',
          '$dir/$fileNameWithoutExt',
        },
        javascript = 'node',
        php = 'php',
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
      { noremap = true, silent = false, desc = 'Run Code' }
    )
    vim.keymap.set(
      'n',
      '<leader>cf',
      ':RunFile<CR>',
      { noremap = true, silent = false, desc = 'Run File' }
    )
    vim.keymap.set(
      'n',
      '<leader>cp',
      ':RunProject<CR>',
      { noremap = true, silent = false, desc = 'Run Project' }
    )
    vim.keymap.set(
      'n',
      '<leader>cl',
      ':RunClose<CR>',
      { noremap = true, silent = false, desc = 'Close Code Runner' }
    )
  end,
}
