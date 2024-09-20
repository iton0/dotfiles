return {
  map = vim.keymap.set,
  silent = { silent = true },
  noremap_silent = { noremap = true, silent = true },
  noremap_silent_desc = function(desc)
    return { noremap = true, silent = true, desc = desc }
  end,

  autocmd = vim.api.nvim_create_autocmd,

  is_loaded = function(plugin)
    -- API to check if plugin is not loaded
    -- Use plugin name not plugin module name
    -- ex) plugin = solarized.nvim vs. solarized
    if require('lazy.core.config').plugins[plugin]._.loaded == nil then
      return false
    else
      return true
    end
  end,
}
