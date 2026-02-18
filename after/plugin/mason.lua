--require('mason').setup {

--}
--require('mason-lspconfig').setup {
--	ensure_installed = { "lua_ls", "erlangls", "jsonls", "bashls", "vimls", "elixirls", "html", "marksman", "dotls", "clangd", "cssls", "lemminx"}
--}

local capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.lsp.config('lua_ls', { capabilities = capabilities })
vim.lsp.config('nil_ls', { capabilities = capabilities })
vim.lsp.config('lemminx', { capabilities = capabilities })
vim.lsp.config('cssls', { capabilities = capabilities })
vim.lsp.config('clangd', { capabilities = capabilities })
vim.lsp.config('dotls', { capabilities = capabilities })
vim.lsp.config('marksman', { capabilities = capabilities })
vim.lsp.config('html', { capabilities = capabilities })
vim.lsp.config('elp', { capabilities = capabilities })
vim.lsp.config('elixirls', { capabilities = capabilities })
vim.lsp.config('jsonls', { capabilities = capabilities })
vim.lsp.config('bashls', { capabilities = capabilities })
vim.lsp.config('vimls', { capabilities = capabilities })



vim.lsp.enable('lua_ls')
vim.lsp.enable('nil_ls')
vim.lsp.enable('lemminx')
vim.lsp.enable('cssls')
vim.lsp.enable('clangd')
vim.lsp.enable('dotls')
vim.lsp.enable('marksman')
vim.lsp.enable('html')
vim.lsp.enable('elp')
vim.lsp.enable('elixirls')
vim.lsp.enable('jsonls')
vim.lsp.enable('bashls')
vim.lsp.enable('vimls')

--mappings
-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', '<M-;>', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set({ 'n', 'v' }, '<M-c>a', vim.lsp.buf.code_action, opts)
		-- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts) using it in telescope now
		vim.keymap.set('n', '<space>f', function()
			vim.lsp.buf.format { async = true }
		end, opts)
	end,
})
vim.keymap.set("n", "<S-k>", "<cmd>lua vim.lsp.buf.hover()<CR>", { silent = true })
