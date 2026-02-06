local augroup = vim.api.nvim_create_augroup("MyCustomAutoCmds", { clear = true })
local function create_autocmd(event, pattern, callback, opts)
	opts = opts or {}
	local settings = {
		group = opts.buffer and nil or augroup,
		callback = callback,
		desc = opts.desc,
	}

	if opts.buffer then
		settings.buffer = opts.buffer
	else
		settings.pattern = pattern or "*"
	end

	vim.api.nvim_create_autocmd(event, settings)
end

create_autocmd("FileType", {
	"markdown",
	"text",
	"tex",
	"gitcommit",
	"vimwiki",
}, function()
	local opt_local = vim.opt_local
	opt_local.wrap = true
	opt_local.linebreak = true
	opt_local.breakindent = true
	opt_local.showbreak = ">> "
	opt_local.cpoptions:append("n")
end, { desc = "Prose wrapping" })

create_autocmd("FileType", "*", function()
	vim.opt_local.formatoptions:remove("o")
end, { desc = "Clean formatoptions" })

create_autocmd("TextYankPost", "*", function()
	vim.hl.on_yank()
end, { desc = "Yank highlight" })

create_autocmd("LspAttach", nil, function(args)
	local client = vim.lsp.get_client_by_id(args.data.client_id)
	local bufnr = args.buf
	if not client then
		return
	end

	if client:supports_method("textDocument/formatting") then
		local group_name = string.format("LspFormat.buf_%d.client_%d", bufnr, client.id)
		local format_grp = vim.api.nvim_create_augroup(group_name, { clear = true })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = format_grp,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({
					bufnr = bufnr,
					id = client.id,
				})
			end,
			desc = "LSP autoformat buffer with client " .. client.name,
		})

		vim.api.nvim_create_autocmd("LspDetach", {
			buffer = bufnr,
			callback = function(detach_args)
				if detach_args.data.client_id == client.id then
					vim.api.nvim_del_augroup_by_name(group_name)
				end
			end,
		})
	end

	if client:supports_method("textDocument/completion") then
		vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = false })
	end
end, { desc = "Initialize LSP buffer" })

create_autocmd("VimEnter", nil, function()
	local servers = vim.iter(vim.api.nvim_get_runtime_file("after/lsp/*.lua", true))
		:map(function(f)
			return vim.fn.fnamemodify(f, ":t:r")
		end)
		:totable()

	if #servers > 0 then
		vim.lsp.enable(servers)
	end
end, { desc = "Delayed LSP startup" })

create_autocmd("BufWritePost", nil, function()
	require("lint").try_lint()
end, { desc = "Trigger linting" })
