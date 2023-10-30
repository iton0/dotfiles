return {
  'CRAG666/code_runner.nvim',
  event = 'BufWritePre',
  opts = {
    filetype = {
      python = "python3 -u"
    }
  }
}
