return {
  'CRAG666/code_runner.nvim',
  keys = {
    { '<leader>x', desc = 'Code Runner' },
  },
  config = function()
    require('code_runner').setup({
      filetype = {
        java = {
          'cd $dir &&',
          'javac $fileName &&',
          'java $fileNameWithoutExt',
        },
        python = 'python3 -u',
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
    vim.keymap.set('n', '<leader>xc', ':RunCode<CR>', { noremap = true, silent = false })
    vim.keymap.set('n', '<leader>xf', ':RunFile<CR>', { noremap = true, silent = false })
    vim.keymap.set('n', '<leader>xft', ':RunFile tab<CR>', { noremap = true, silent = false })
    vim.keymap.set('n', '<leader>xp', ':RunProject<CR>', { noremap = true, silent = false })
    vim.keymap.set('n', '<leader>xc', ':RunClose<CR>', { noremap = true, silent = false })
  end,
}
