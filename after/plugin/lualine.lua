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
		lualine_z = {
    {
      'fileformat',
      symbols = {
        unix = '󰻀', -- e712
        dos = '',  -- e70f
        mac = '',  -- e711
      }
    }
  }
	}
}
