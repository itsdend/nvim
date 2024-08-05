local rainbow_delimiters = require 'rainbow-delimiters'
vim.g.rainbow_delimiters = {
	strategy = {
		[''] = rainbow_delimiters.strategy['global'],
		erlang = rainbow_delimiters.strategy['global']
	},
	query = {
		[''] = 'rainbow-delimiters',
	},
	priority = {
		[''] = 510,
	},
	highlight = {
	},
}
