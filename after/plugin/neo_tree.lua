require('neo-tree').setup({
	default_component_configs = {
		close_if_last_window = false,
		window = {
			position = "right"
		},
		name = {
			use_git_status_colors = true
		}
	},
	event_handlers = {
		{
			event = "file_opened",
			handler = function(file_path)
				require("neo-tree.command").execute({ action = "close" })
			end
		},
		{
			event = "VimEnter",
			handler = function(file_path)
				require("neo-tree.command").execute({ action = "close" })
			end
		}
	}
})
vim.keymap.set("n", "<A-u>e", ":Neotree filesystem reveal right toggle<CR>",
	{ noremap = true, silent = true })
vim.keymap.set("n", "<A-u><A-e>", ":Neotree filesystem reveal right toggle<CR>",
	{ noremap = true, silent = true })
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.cmd(":Neotree right")
		-- vim.cmd(':wincmd h')  --start on the focus right
	end,
})
