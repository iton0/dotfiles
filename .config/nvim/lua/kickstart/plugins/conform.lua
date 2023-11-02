-- Autoformats specifically for
-- JavaScript, TypeScript,
-- HTML and CSS files
--
-- autoformat.lua should cover
-- the rest of the file types
return {
	'stevearc/conform.nvim',
	ft = { 'javascript', 'typescript', 'html', 'css' },
	cmd = { 'ConformInfo' },
	opts = {
		formatters_by_ft = {
			javascript = { { 'prettierd', 'prettier' } },
			typescript = { { 'prettierd', 'prettier' } },
			html = { { 'prettierd', 'prettier' } },
			css = { { 'prettierd', 'prettier' } },
		},
		format_on_save = { timeout_ms = 500, lsp_fallback = true },
		formatters = {
			shfmt = {
				prepend_args = { '-i', '2' },
			},
		},
	},
	init = function()
		-- If you want the formatexpr, here is the place to set it
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
