local builtin = require('telescope.builtin')
local telescope = require('telescope')

vim.keymap.set('n', '<M-f>i', builtin.find_files, { noremap = true, silent = true })
vim.keymap.set('n', '<M-f><M-i>', builtin.find_files, { noremap = true, silent = true })

vim.keymap.set('n', '<M-f>o', builtin.lsp_document_symbols, { noremap = true, silent = true })
vim.keymap.set('n', '<M-f><M-o>', builtin.lsp_document_symbols, { noremap = true, silent = true })

vim.keymap.set('n', '<M-f>f', builtin.grep_string, { noremap = true, silent = true })
vim.keymap.set('n', '<M-f><M-f>', builtin.grep_string, { noremap = true, silent = true })

vim.keymap.set('n', '<M-f>s', builtin.live_grep, { noremap = true, silent = true })
vim.keymap.set('n', '<M-f><M-s>', builtin.live_grep, { noremap = true, silent = true })

vim.keymap.set('n', '<M-f>k', builtin.keymaps, { noremap = true, silent = true })
vim.keymap.set('n', '<M-f><M-k>', builtin.keymaps, { noremap = true, silent = true })

vim.keymap.set('n', '<M-f>b', builtin.buffers, { noremap = true, silent = true })
vim.keymap.set('n', '<M-f><M-b>', builtin.buffers, { noremap = true, silent = true })

vim.keymap.set('n', '<M-f>t', '<cmd>Telescope toggleterm_manager<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<M-f><M-t>', '<cmd>Telescope toggleterm_manager<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<M-f>r', builtin.lsp_references, { desc = 'find refs in repo', noremap = true, silent = true })

vim.keymap.set('n', '<M-f>d', function()
	builtin.lsp_definitions({ jump_type = 'never' })
end, { noremap = true, silent = true })

telescope.setup({
	defaults = {
		mappings = {
			i = {
				['<C-l>'] = 'select_vertical',
				['<C-j>'] = 'select_horizontal',
				['<CR>'] = 'select_default',
			},
			n = {
				['<C-l>'] = 'select_vertical',
				['<C-j>'] = 'select_horizontal',
				['<CR>'] = 'select_default',
			},
		},
		file_ignore_patterns = { '_build/*' },
		sorting_strategy = 'ascending',
		layout_config = {
			prompt_position = 'top',
			height = 0.5,
		},
	},
})
