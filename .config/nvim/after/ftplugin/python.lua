local formatprg = ""
local filename = vim.fn.expand("%:p")

if vim.fn.executable("ruff") == 1 then
    formatprg = string.format(
        "ruff check -s --select I --fix-only --stdin-filename %s - | ruff format --stdin-filename %s -",
        filename, filename
    )
elseif vim.fn.executable("black") == 1 then
    formatprg = "black -q - 2>/dev/null"

    if vim.fn.executable("isort") == 1 then
        formatprg = formatprg .. " | isort -q -"
    end
end

if formatprg ~= "" then
    vim.opt_local.formatprg = formatprg
end
