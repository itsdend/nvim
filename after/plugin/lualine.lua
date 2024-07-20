require 'lualine'.setup {
	options = {
		icons_enabled = true,
		extensions = {'neo-tree'}
	},
	sections = {
		lualine_c = {},
		lualine_x = {
			'encoding'}
	},
	tabline = {
		lualine_a = { 'filetype', 'filename' },
		lualine_z = {{
			'datetime',
			style = '%H:%M'
					}}
	}
}
