return {
  'David-Kunz/gen.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    display_mode = 'float', -- The display mode. Can be "float" or "split".
    show_prompt = false, -- Shows the Prompt submitted to Ollama.
    show_model = false, -- Displays which model you are using at the beginning of your chat session.
    no_auto_close = false, -- Never closes the window automatically.
    debug = false, -- Prints errors and the command which is run.
  },
  config = function()
    vim.keymap.set({ 'n', 'v' }, '<leader>lu', ':Gen<CR>', { noremap = true, silent = true, desc = 'Toggle LLM' })
    vim.keymap.set('v', '<leader>lr', ':Gen Review_Code<CR>', { noremap = true, silent = true, desc = 'Review Code' })
    vim.keymap.set('v', '<leader>le', ':Gen Enhance_Code<CR>', { noremap = true, silent = true, desc = 'Enhance Code' })
    vim.keymap.set('v', '<leader>ls', ':Gen Summarize<CR>', { noremap = true, silent = true, desc = 'Summarize' })
    vim.keymap.set('v', '<leader>lc', ':Gen Make_Concise<CR>', { noremap = true, silent = true, desc = 'Make Concise' })
  end,
}
