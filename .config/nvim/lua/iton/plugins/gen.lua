return {
  'David-Kunz/gen.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    model = 'mistral', -- The default model to use.
    display_mode = 'float', -- The display mode. Can be "float" or "split".
    show_prompt = false, -- Shows the Prompt submitted to Ollama.
    show_model = false, -- Displays which model you are using at the beginning of your chat session.
    no_auto_close = false, -- Never closes the window automatically.
    init = function(options)
      pcall(io.popen, 'ollama serve > /dev/null 2>&1 &')
    end,
    -- Function to initialize Ollama
    command = 'curl --silent --no-buffer -X POST http://localhost:11434/api/generate -d $body',
    -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
    -- This can also be a lua function returning a command string, with options as the input parameter.
    -- The executed command must return a JSON object with { response, context }
    -- (context property is optional).
    list_models = '<function>', -- Retrieves a list of model names
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
