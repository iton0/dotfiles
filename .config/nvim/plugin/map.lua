local map = vim.keymap.set
local function map_toggle(char, expr, desc)
        map("n", "yo" .. char, expr, { desc = "[Y]ield [O]ption " .. desc })
end

map_toggle("q", function()
        local qf_exists = false

        for _, win in ipairs(vim.api.nvim_list_wins()) do
                local buf = vim.api.nvim_win_get_buf(win)
                if vim.bo[buf].buftype == "quickfix" then
                        qf_exists = true
                        break
                end
        end

        if qf_exists then
                vim.cmd("cclose")
        else
                vim.cmd("copen")
                vim.cmd("wincmd p")
        end
end, "Quickfix list")

map_toggle("l", function()
        local current_win = vim.api.nvim_get_current_win()
        local loclist_win = vim.fn.getloclist(current_win, { winid = 0 }).winid

        if loclist_win > 0 then
                vim.cmd("lclose")
        else
                local success, _ = pcall(vim.cmd, "lopen")
                if success then
                        vim.cmd("wincmd p")
                end
        end
end, "Location list")

map({ "n", "x" }, "gy", '"+y', { desc = "Copy to system" })
map("n", "gp", '"+p', { desc = "Paste from system" })
map("x", "gp", '"+P', { desc = "Paste from system (No register overwrite)" })
map("n", "go", "gO", { remap = true })

map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("x", "J", ":move '>+1<CR>gv=gv", { desc = "Move selection down" })
map("x", "K", ":move '<-2<CR>gv=gv", { desc = "Move selection up" })
map("x", "<", "<gv")
map("x", ">", ">gv")
map("n", "<BS>", "<cmd>nohlsearch<cr>")

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")


for key, dir in pairs({ h = "Left", j = "Down", k = "Up", l = "Right" }) do
        map("n", "<C-" .. key .. ">", "<cmd>TmuxNavigate" .. dir .. "<cr>", {
                desc = "Focus " .. dir:lower() .. " window/pane"
        })
        map("t", "<C-" .. key .. ">", [[<C-\><C-n><cmd>TmuxNavigate]] .. dir .. "<cr>", {
                desc = "Focus " .. dir:lower() .. " window/pane from terminal"
        })
end
map("t", "<Esc><Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
map("n", "<C-space>", "<Nop>")

map("n", "-", function()
        if not package.loaded["mini.files"] then
                require("mini.files").setup()
        end
        MiniFiles.open(vim.api.nvim_buf_get_name(0))
end, { desc = "Explorer (mini.files)" })
map("n", "<leader><leader>", function()
        if not package.loaded["mini.pick"] then
                require("mini.pick").setup()
        end
        MiniPick.builtin.resume()
end)
map("n", "<leader>f", function()
        if not package.loaded["mini.pick"] then
                require("mini.pick").setup()
        end
        MiniPick.builtin.files()
end)
map("n", "<leader>/", function()
        if not package.loaded["mini.pick"] then
                require("mini.pick").setup()
        end
        MiniPick.builtin.grep_live()
end)
map_toggle("d", function()
        if not package.loaded["mini.diff"] then
                require("mini.diff").setup({
                        mappings = {
                                apply = "gha",
                                reset = "ghr",
                        }
                })
        end
        MiniDiff.toggle_overlay(0)
end, "Diff Overlay")
