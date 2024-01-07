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
  vim.keymap.set('n', '<leader>i', function()
    return require('nvim-toggler').toggle()
  end, { desc = 'Invert' }),
}
