return {
  'nguyenvukhang/nvim-toggler',
  opts = {
    inverses = {
      ['TRUE'] = 'FALSE',
      ['Yes'] = 'No',
      ['YES'] = 'NO',
      ['Pre'] = 'Post',
      ['start'] = 'stop',
      ['1'] = '0',
      ['<'] = '>',
      ['('] = ')',
      ['['] = ']',
      ['{'] = '}',
      ['/'] = [[\]],
      ['+'] = '-',
      ["'"] = '"',
    },
  },
  vim.keymap.set(
    'n',
    '<leader>i',
    "<cmd>lua require('nvim-toggler').toggle()<cr>",
    { desc = 'Invert' }
  ),
}
