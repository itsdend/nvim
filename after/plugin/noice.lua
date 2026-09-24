require("noice").setup({
	messages = {
		enabled = true,
		view = "mini",
		view_error = "notify",
		view_warn = "notify",
		view_history = "split",
	},
	lsp = {
		progress = {
			enabled = false,
		},
		message = {
			enabled = true,
		},
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
	},
	presets = {
		bottom_search = false,
		command_palette = true,
		long_message_to_split = true,
		inc_rename = false,
		lsp_doc_border = false,
	},
	routes = {
		{
			filter = {
				any = {
					{ event = "msg_show", kind = "", find = "written" },
					{ event = "notify", kind = "info", find = "hidden" },
					{ event = "notify", kind = "warn", find = "" },
					{ event = "lsp", kind = "message", find = "missing an erlang_ls" },
				},
			},
			opts = { skip = true },
		},
	},
})

vim.keymap.set('n', '<M-i>n', '<cmd>NoiceDismiss<CR>', { noremap = true, silent = true })
