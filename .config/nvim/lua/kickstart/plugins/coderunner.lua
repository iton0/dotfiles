return {
  "CRAG666/code_runner.nvim",
  config = true,
  event = 'BufWritePost',
  opts = {
    filetype = {
      python = "python3 -u"
    }
  }
}
