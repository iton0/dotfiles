local augroup = vim.api.nvim_create_augroup("MyCustomAutoCmds", { clear = true })
local function create_autocommand(event, pattern, callback, opts)
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

create_autocommand("FileType", {
	"markdown",
	"text",
	"tex",
	"gitcommit",
	"vimwiki",
}, function()
	local option_local = vim.opt_local
	option_local.wrap = true
	option_local.linebreak = true
	option_local.breakindent = true
	option_local.showbreak = ">> "
	option_local.cpoptions:append("n")
end, { desc = "Prose wrapping" })

create_autocommand("FileType", "*", function()
	vim.opt_local.formatoptions:remove("o")
end, { desc = "Clean formatoptions" })

create_autocommand("TextYankPost", "*", function()
	vim.hl.on_yank()
end, { desc = "Yank highlight" })

create_autocommand("LspAttach", nil, function(args)
	local client = vim.lsp.get_client_by_id(args.data.client_id)
	local buffer_number = args.buf
	if not client then
		return
	end

	if client:supports_method("textDocument/formatting") then
		local group_name = string.format("LspFormat.buf_%d.client_%d", buffer_number, client.id)
		local format_grp = vim.api.nvim_create_augroup(group_name, { clear = true })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = format_grp,
			buffer = buffer_number,
			callback = function()
				vim.lsp.buf.format({
					bufnr = buffer_number,
					id = client.id,
				})
			end,
			desc = "LSP autoformat buffer with client " .. client.name,
		})

		vim.api.nvim_create_autocmd("LspDetach", {
			buffer = buffer_number,
			callback = function(detach_args)
				if detach_args.data.client_id == client.id then
					vim.api.nvim_del_augroup_by_name(group_name)
				end
			end,
		})
	end

	if client:supports_method("textDocument/completion") then
		vim.lsp.completion.enable(true, client.id, buffer_number, { autotrigger = false })
	end
end, { desc = "Initialize LSP buffer" })

create_autocommand("VimEnter", nil, function()
	local lsps = vim.iter(vim.api.nvim_get_runtime_file("after/lsp/*.lua", true))
		:map(function(f)
			return vim.fn.fnamemodify(f, ":t:r")
		end)
		:totable()

	if #lsps > 0 then
		vim.lsp.enable(lsps)
	end
end, { desc = "Delayed LSP startup" })

create_autocommand("BufWritePost", nil, function()
	require("lint").try_lint()

	local qf_winid = vim.fn.getqflist({ winid = 0 }).winid
	if qf_winid ~= 0 then
		vim.diagnostic.setqflist({ open = false })
	end

	local loc_winid = vim.fn.getloclist(0, { winid = 0 }).winid
	if loc_winid ~= 0 then
		vim.diagnostic.setloclist({ open = false })
	end
end, { desc = "Lint and refresh diagnostic lists" })
