-- Useful plugin to show you pending keybinds.
return {
  'folke/which-key.nvim',
  lazy = true,
  init = function()
    vim.o.timeout = true
    vim.o.timeout = 300
  end,
  config = true,
}
