local function get_python_path()
    if vim.env.VIRTUAL_ENV then
        local venv_python_path = vim.env.VIRTUAL_ENV .. "/bin/python"
        vim.notify("basedpyright python path: " .. venv_python_path)
        return venv_python_path
    end
    local python_path = vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
    return python_path
end

local function set_python_path(command)
    local path = command.args
    local clients = vim.lsp.get_clients {
        bufnr = vim.api.nvim_get_current_buf(),
        name = "basedpyright",
    }
    for _, client in ipairs(clients) do
        if client.settings then
            ---@diagnostic disable-next-line: param-type-mismatch
            client.settings.python = vim.tbl_deep_extend("force", client.settings.python or {}, { pythonPath = path })
        else
            client.config.settings = vim.tbl_deep_extend("force", client.config.settings,
                { python = { pythonPath = path } })
        end
        client:notify("workspace/didChangeConfiguration", { settings = nil })
    end
end

return {
    cmd = { "basedpyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = {
        "pyrightconfig.json",
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
        ".git",
    },
    settings = {
        basedpyright = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly",
            },
        },
        python = {
            pythonPath = get_python_path(),
        },
    },
    on_attach = function(client, bufnr)
        vim.api.nvim_buf_create_user_command(bufnr, "LspPyrightGetPythonPath", function()
            print(client.settings.python.pythonPath)
        end, {
            desc = "Print the current python path",
        })

        vim.api.nvim_buf_create_user_command(bufnr, "LspPyrightSetPythonPath", set_python_path, {
            desc = "Reconfigure basedpyright with the provided python path",
            nargs = 1,
            complete = "file",
        })
    end,
}
