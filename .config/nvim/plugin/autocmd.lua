local augroup = vim.api.nvim_create_augroup("MyCustomAutoCmds", { clear = true })
local function autocmd(event, pattern, callback, opts)
        opts = opts or {}
        local settings = {
                group = opts.buffer and nil or augroup,
                callback = callback,
                desc = opts.desc,
                once = opts.once
        }

        if opts.buffer then
                settings.buffer = opts.buffer
        else
                settings.pattern = pattern or "*"
        end

        vim.api.nvim_create_autocmd(event, settings)
end

autocmd("FileType", "*", function()
        local opt_local = vim.opt_local

        opt_local.formatoptions:remove("o")

        local prose_fts = {
                ["markdown"] = true,
                ["text"] = true,
                ["tex"] = true,
                ["gitcommit"] = true,
                ["vimwiki"] = true,
        }

        if prose_fts[vim.bo.filetype] then
                opt_local.wrap = true
                opt_local.linebreak = true
                opt_local.breakindent = true
                opt_local.showbreak = ">> "
                opt_local.cpoptions:append("n")
        end
end, { desc = "Clean formatoptions and set Prose for specific types" })

autocmd("TextYankPost", "*", function()
        vim.hl.on_yank()
end, { desc = "Yank highlight" })

autocmd("LspAttach", "", function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local bufnr = ev.buf
        if not client then
                return
        end

        if client:supports_method("textDocument/formatting") then
                vim.keymap.set("n", "<M-f>", function()
                        vim.lsp.buf.format({
                                async = true,
                                bufnr = bufnr,
                                id = client.id,
                        })
                end, { buffer = bufnr, desc = "LSP format" })
        end

        if client:supports_method("textDocument/completion") then
                vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = false })
        end
end, { desc = "Initialize LSP buffer" })

autocmd("FileType", "*", function()
        require("mini.ai").setup()
        require("mini.surround").setup()

        vim.lsp.enable({
                "lua-language-server",
                "basedpyright",
                "vtsls",
        })
end, { desc = "Delayable plugin startup (including lsp)", once = true })

do
        local linter_configured = false
        autocmd("BufWritePost", "*", function()
                local lint = require("lint")

                if not linter_configured then
                        lint.linters_by_ft = {
                                go = { "golangcilint" },
                                sh = { "shellcheck" },
                                python = { "ruff" },
                                elixir = { "credo" },
                                c = { "cppcheck" },
                                cpp = { "cppcheck" },
                                typescript = { "oxlint" },
                                javascript = { "oxlint" },
                        }
                        linter_configured = true
                end

                lint.try_lint()
        end, { desc = "Lint and refresh diagnostic lists" })
end
