return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    lsp = {
      progress = { enabled = false },
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
    },
    -- you can enable a preset for easier configuration
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = true, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    'MunifTanjim/nui.nvim',
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    {
      -- Better notification manager
      'rcarriga/nvim-notify',
      opts = {
        background_colour = '#000000',
        fps = 5,
        render = 'wrapped-compact',
        minimum_width = 0,
        maximum_width = 50,
        stages = 'static',
        timeout = 3000,
      },
    },
  },
  -- To open Lazy.nvim ui
  -- not related to the
  -- dressing.nvim plugin
  vim.keymap.set('n', '<leader>l', 'Lazy.nvim'),
  vim.keymap.set(
    'n',
    '<leader>ls',
    ':Lazy sync <cr>',
    { noremap = true, silent = true, desc = 'Sync' }
  ),
  vim.keymap.set(
    'n',
    '<leader>ll',
    ':Lazy <cr>',
    { noremap = true, silent = true, desc = 'Toggle Home' }
  ),
  vim.keymap.set(
    'n',
    '<leader>lp',
    ':Lazy profile<cr>',
    { noremap = true, silent = true, desc = 'Profile' }
  ),
}
