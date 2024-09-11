return {
  map = vim.keymap.set,
  silent = { silent = true },
  noremap_silent = { noremap = true, silent = true },
  noremap_silent_desc = function(desc)
    return { noremap = true, silent = true, desc = desc }
  end,
}
