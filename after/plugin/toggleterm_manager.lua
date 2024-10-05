local toggleterm_manager = require("toggleterm-manager")
local actions = toggleterm_manager.actions

require('toggleterm-manager').setup({
	mappings = {
		i = {
			 ["<CR>"] = { action = actions.open_term, exit_on_action = true }, -- toggles terminal open/closed
			 ["<C-d>"] = { action = actions.delete_term, exit_on_action = false }
		 }
	 }
})

