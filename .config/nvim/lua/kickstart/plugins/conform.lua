-- Autoformats specifically for
-- JavaScript, TypeScript,
-- HTML and CSS files
--
-- autoformat.lua should cover
-- the rest of the file types
return {
	'stevearc/conform.nvim',
	event = { 'BufReadPre', 'BufNewFile' },
	opts = {
		formatters_by_ft = {
			javascript = { 'prettierd' },
			typescript = { 'prettierd' },
			html = { 'prettierd' },
			css = { 'prettierd' },
			lua = { 'stylua' },
			cpp = { 'clang-format' },
			c = { 'clang-format' },
			java = { 'google-java-format' },
			python = { 'black' },
			php = { 'php-cs-fixer' },
		},
		format_on_save = { async = false, timeout_ms = 500, lsp_fallback = true },
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
