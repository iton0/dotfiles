local M = {}

---
--Function for faster keymap setup replaces vim.keymap.set
--
---@param mode (string|table)
---@param keys string
---@param func (string|function)
---@param noremap (boolean|nil)
---@param silent (boolean|nil)
---@param desc (string|nil)
--
M.map = function(mode, keys, func, noremap, silent, desc)
  vim.keymap.set(
    mode,
    keys,
    func,
    { noremap = noremap, silent = silent, desc = desc }
  )
end

M.prenew = { 'BufReadPre', 'BufNewFile' }
M.postnew = { 'BufReadPost', 'BufNewFile' }

M.active_statusline = { fg = '#a0aac2', bg = '#1c1e26' }
M.inactive_statusline = { fg = '#6e6e6e', bg = '#1c1e26' }

-- Define `M.lsp_excluded_filetypes` as a set-like table
M.lsp_excluded_filetypes = {
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

return M
