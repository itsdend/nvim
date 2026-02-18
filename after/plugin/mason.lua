--require('mason').setup {

--}
--require('mason-lspconfig').setup {
--	ensure_installed = { "lua_ls", "erlangls", "jsonls", "bashls", "vimls", "elixirls", "html", "marksman", "dotls", "clangd", "cssls", "lemminx"}
--}

local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig').lua_ls.setup { capabilities = capabilities }
require('lspconfig').nil_ls.setup { capabilities = capabilities }
require('lspconfig').lemminx.setup { capabilities = capabilities }
require('lspconfig').cssls.setup { capabilities = capabilities }
require('lspconfig').clangd.setup { capabilities = capabilities }
require('lspconfig').dotls.setup { capabilities = capabilities }
require('lspconfig').marksman.setup { capabilities = capabilities }
require('lspconfig').html.setup { capabilities = capabilities }
require('lspconfig').elp.setup { capabilities = capabilities }
require('lspconfig').elixirls.setup { capabilities = capabilities }
require('lspconfig').jsonls.setup { capabilities = capabilities }
require('lspconfig').bashls.setup { capabilities = capabilities }
require('lspconfig').vimls.setup { capabilities = capabilities }



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
