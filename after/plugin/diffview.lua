require 'diffview'.setup()
vim.keymap.set('n', '<A-g>o', ': DiffviewOpen<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-g>c', ': DiffviewClose<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-g>r', ': DiffviewRefresh<CR>', { noremap = true, silent = true })
