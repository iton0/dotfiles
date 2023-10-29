return {
	-- Improved location list navigation
	-- Labelled floating window showing a snippet of some buffer
	'cbochs/portal.nvim',
	event        = { 'BufReadPre', 'BufNewFile' },
	-- Optional dependencies
	dependencies = {
		'cbochs/grapple.nvim',
		'ThePrimeagen/harpoon'
	},
	config       = function()
		-- Enable opening portals both forwards and backwards for portal.nvim
		vim.keymap.set("n", "<leader>o", "<cmd>Portal jumplist backward<cr>")
		vim.keymap.set("n", "<leader>i", "<cmd>Portal jumplist forward<cr>")
	end
}
