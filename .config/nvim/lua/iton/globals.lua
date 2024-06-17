local lsp_excluded_filetypes = {
  [''] = true,
  [' '] = true,
  ['lazy'] = true,
  ['oil'] = true,
  ['gitcommit'] = true,
  ['gitconfig'] = true,
  ['gitignore'] = true,
  ['gitrebase'] = true,
  ['gitmerge'] = true,
  ['jproperties'] = true,
  ['xml'] = true,
  ['help'] = true,
  ['dbee'] = true,
  ['dapui_watches'] = true,
  ['dapui_stacks'] = true,
  ['dapui_breakpoints'] = true,
  ['dapui_scopes'] = true,
  ['dapui_console'] = true,
  ['dap-repl'] = true,
  ['zsh'] = true,
  ['NeogitConsole'] = true,
  ['NeogitCommitMessage'] = true,
  ['NeogitStatus'] = true,
  ['NeogitPopup'] = true,
  ['NeogitCommitView'] = true,
  ['yaml'] = true,
  ['html'] = true,
  ['log'] = true,
  ['css'] = true,
  ['vim'] = true,
  ['qf'] = true,
  ['json'] = true,
  ['toml'] = true,
  ['markdown'] = true,
  ['sh'] = true,
  ['text'] = true,
  ['tmux'] = true,
  ['lspinfo'] = true,
  ['mason'] = true,
  ['netrw'] = true,
  ['TelescopePrompt'] = true,
}

return {
  map = vim.keymap.set,
  silent = { silent = true },
  noremap_silent = { noremap = true, silent = true },
  noremap_silent_desc = function(desc)
    return { noremap = true, silent = true, desc = desc }
  end,

  prenew = { 'BufReadPre', 'BufNewFile' },
  postnew = { 'BufReadPost', 'BufNewFile' },

  -- Check if the current filetype is in the LSP excluded list
  is_lsp_excluded_filetype = function()
    local current_filetype = vim.bo.filetype
    return lsp_excluded_filetypes[current_filetype] or false
  end,
}
