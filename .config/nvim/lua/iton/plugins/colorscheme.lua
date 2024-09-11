return {
  'slugbyte/lackluster.nvim',
  dev = true,
  init = function()
    local lackluster = require('lackluster')

    lackluster.setup({
      tweak_ui = {
        disable_undercurl = true,
      },
      tweak_syntax = {
        comment = lackluster.color.gray6,
      },
      tweak_background = {
        normal = '#1c1c1c',
        telescope = 'none',
        menu = lackluster.color.gray3,
      },
    })

    vim.cmd.colorscheme('lackluster-night')

    vim.cmd('highlight TelescopeMatching gui=none')
    vim.cmd('highlight CursorLine ctermbg=none guibg=none')
  end,
}
