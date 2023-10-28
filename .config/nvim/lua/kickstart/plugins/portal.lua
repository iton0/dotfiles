return {
	-- Improved location list navigation
	-- Labelled floating window showing a snippet of some buffer
	'cbochs/portal.nvim',
	event = 'BufEnter',
	-- Optional dependencies
	dependencies = {
		'cbochs/grapple.nvim',
		'ThePrimeagen/harpoon'
	},
}
