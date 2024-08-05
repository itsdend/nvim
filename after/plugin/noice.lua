require("noice").setup({
	messages = {
		enabled = true,
		view = "mini",       -- default view for messages
		view_error = "notify", -- view for errors
		view_warn = "notify", -- view for warnings
		view_history = "messages", -- view for :messages
	},
	lsp = {
		progress = {
			enabled = false,
			view = "notify"
		},
		message = {
			enabled = true,
			view = nil
		},
		-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
		},
	},
	-- you can enable a preset for easier configuration
	presets = {
		bottom_search = false,  -- use a classic bottom cmdline for search
		command_palette = true, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = false,     -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = false, -- add a border to hover docs and signature help
	},
	routes = {
		{
			filter = {
				any = {
					{
						event = "msg_show",
						kind = "",
						find = "written",
					},
					{
						event = 'notify',
						kind = 'info',
						find = 'hidden'
					},
					{
						event = 'notify',
						kind = 'warn',
						find = ''
					},
					{
						event = 'lsp',
						kind = "message",
						find = "missing an erlang_ls"
					}
				}
			},
			opts = { skip = true },
		}
		,
	}
})
vim.keymap.set('n', '<M-i>n', ': NoiceDismiss<CR>', { noremap = true, silent = true })
