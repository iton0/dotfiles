-- Useful plugin to show you pending keybinds.
--
-- Keys currently up for grabs with <leader> key
-- mapping: (alphabet)
-- j, n, o, p, u, v, x, y
return {
  'folke/which-key.nvim',
  init = function()
    vim.o.timeout = true
    vim.o.timeout = 500
  end,
  config = function()
    -- document existing key chains
    require('which-key').register({
      ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
      ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
      ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
      ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
      ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
      ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
      ['<leader>h'] = { name = '[H]arpoon', _ = 'which_key_ignore' },
      ['<leader>b'] = { name = 'De[B]ugger', _ = 'which_key_ignore' },
      ['<leader>a'] = { name = 'Swap Parameters', _ = 'which_key_ignore' },
    })
  end,
  vim.keymap.set(
    'n',
    '<leader>k',
    "<cmd>lua require('which-key').show()<cr>",
    { noremap = true, silent = true, desc = 'Whichkey' }
  ),
}
