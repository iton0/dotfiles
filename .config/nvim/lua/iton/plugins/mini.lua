return {
  -- Better Around/Inside textobjects
  --
  -- Examples:
  --  - ya)  - [Y]ank [A]round [)]parenthen
  --  - yinq - [Y]ank [I]nside [N]ext [']quote
  --  - ci'  - [C]hange [I]nside [']quote
  {
    'echasnovski/mini.ai',
    version = false,
    opts = { n_lines = 500 },
    keys = { { 'y' }, { 'c' }, { 'd' }, { 'v' } },
  },

  -- Add/delete/replace surroundings (brackets, quotes, etc.)
  -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
  -- - sd'   - [S]urround [D]elete [']quotes
  -- - sr)'  - [S]urround [R]eplace [)] [']
  {
    'echasnovski/mini.surround',
    version = false,
    opts = { silent = true },
    keys = { { 's' } },
  },
}
