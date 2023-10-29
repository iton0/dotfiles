return {
  "CRAG666/code_runner.nvim",
  config = function()
    -- Code Runner keymaps
    vim.keymap.set('n', '<leader>x', ':RunCode<CR>', { noremap = true, silent = false })
  end,
  event = 'BufWritePost',
  opts = {
    filetype = {
      python = "python3 -u"
    }
  }
}
