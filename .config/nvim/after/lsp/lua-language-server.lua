return {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = {
        ".luarc.json",
        ".luarc.jsonc",
        ".luacheckrc",
        ".stylua.toml",
        "stylua.toml",
        "selene.toml",
        "selene.yml",
        ".git",
    },
    on_attach = function(client, _)
        client.server_capabilities.completionProvider.triggerCharacters = { ".", ":", "#", "(" }
    end,
    settings = {
        Lua = {
            runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
            workspace = {
                checkThirdParty = false,
                ignoreSubmodules = true,
                library = { vim.env.VIMRUNTIME },
            },
        },
    },
}
