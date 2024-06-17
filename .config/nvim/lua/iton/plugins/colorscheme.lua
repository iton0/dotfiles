return {
  'slugbyte/lackluster.nvim',
  dev = true,
  priority = 1000,
  init = function()
    local lackluster = require('lackluster')

    lackluster.setup({
      tweak_ui = {
        disable_undercurl = true,
      },
      tweak_syntax = {
        comment = lackluster.color.gray4,
      },
      tweak_background = {
        normal = 'none',
        telescope = 'none',
        menu = lackluster.color.gray3,
      },
    })

    vim.cmd.colorscheme('lackluster-hack')

    vim.cmd('highlight TelescopeMatching gui=none')
    vim.cmd('highlight CursorLine ctermbg=none guibg=none')
  end,
}
