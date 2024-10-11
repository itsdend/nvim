require('telescope.builtin')

vim.keymap.set('n', '<M-f>i', '<cmd>Telescope find_files<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<M-f><M-i>', '<cmd>Telescope find_files<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<M-f>o', '<cmd>Telescope lsp_document_symbols<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<M-f><M-o>', '<cmd>Telescope lsp_document_symbols<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<M-f>f', '<cmd>Telescope grep_string<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<M-f><M-f>', '<cmd>Telescope grep_string<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<M-f>s', '<cmd>Telescope live_grep<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<M-f><M-s>', '<cmd>Telescope live_grep<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<M-f>k', '<cmd>Telescope keymaps<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<M-f><M-k>', '<cmd>Telescope keymaps<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<M-f>b', '<cmd>Telescope buffers<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<M-f><M-b>', '<cmd>Telescope buffers<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<M-f>t', '<cmd> Telescope toggleterm_manager<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<M-f><M-t>', '<cmd> Telescope toggleterm_manager<CR>', {noremap = true, silent = true})


vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { desc = 'Goto [R]eferences (Telescope)' })

local telescope = require('telescope')
-- Setup Telescope with custom key mappings
telescope.setup {
	defaults = {
		mappings = {
			i = {
				['<C-l>'] = 'select_vertical',
				['<C-j>'] = 'select_horizontal',
				['<CR>'] = 'select_default'
			},
			n = {
				['<C-l>'] = 'select_vertical',
				['<C-j>'] = 'select_horizontal',
				['<CR>'] = 'select_default'
			}
		},
		file_ignore_patterns = {"_build/*"},
		file_previewer = require('telescope.previewers').vim_buffer_cat.new,
		sorting_strategy = 'ascending',
		layout_config = {
			prompt_position = 'top',
			height = 0.5
		}
	},
}
