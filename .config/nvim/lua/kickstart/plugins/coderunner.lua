return {
  'CRAG666/code_runner.nvim',
  event = { 'BufReadPost', 'BufWritePre' },
  opts = {
    filetype = {
      python = 'python3 -u',
    },
  },
}
