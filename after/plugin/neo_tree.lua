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
