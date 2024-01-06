return {
  'andrewferrier/debugprint.nvim',
  keys = {
    {
      '<leader>b',
      '',
    },
  },
  opts = {
    create_keymaps = false,
    create_commands = false,
    print_tag = ' ',
  },
  version = '*',
  vim.keymap.set('n', '<Leader>bs', function()
    -- Note: setting `expr=true` and returning the value are essential
    return require('debugprint').debugprint()
  end, {
    expr = true,
    desc = 'Plain Debug Below',
  }),
  vim.keymap.set('n', '<Leader>bS', function()
    -- Note: setting `expr=true` and returning the value are essential
    return require('debugprint').debugprint({ above = true })
  end, {
    expr = true,
    desc = 'Plain Debug Above',
  }),
  vim.keymap.set('n', '<Leader>bv', function()
    -- Note: setting `expr=true` and returning the value are essential
    return require('debugprint').debugprint({ variable = true })
  end, {
    expr = true,
    desc = 'Variable Debug Below',
  }),
  vim.keymap.set('n', '<Leader>bV', function()
    -- Note: setting `expr=true` and returning the value are essential
    return require('debugprint').debugprint({ above = true, variable = true })
  end, {
    expr = true,
    desc = 'Variable Debug Above',
  }),
  vim.keymap.set('n', '<Leader>bm', function()
    -- Note: setting `expr=true` and returning the value are essential
    -- It's also important to use motion = true for operator-pending motions
    return require('debugprint').debugprint({ motion = true })
  end, {
    expr = true,
    desc = 'Vim Motion Debug Below',
  }),
  vim.keymap.set('n', '<leader>bd', function()
    return require('debugprint').deleteprints()
  end, {
    desc = 'Delete All Debugs',
  }),
}
