return {
  'nguyenvukhang/nvim-toggler',
  keys = {
    {
      '<leader>i',
      "<cmd>require('nvim-toggler').toggle()<cr>",
      desc = 'Invert',
    },
  },
  opts = {
    inverses = {
      ['TRUE'] = 'FALSE',
      ['Yes'] = 'No',
      ['YES'] = 'NO',
      ['open'] = 'closed',
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
}
