-- =================MUST=====================================
local util = require("lspconfig.util")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.workspace = {
    didChangeWatchedFiles = {
        dynamicRegistration = true
    }
}

vim.lsp.config('lua_ls', { capabilities = capabilities })
vim.lsp.config('nil_ls', { capabilities = capabilities })
vim.lsp.config('lemminx', { capabilities = capabilities })
vim.lsp.config('cssls', { capabilities = capabilities })
vim.lsp.config('clangd', { capabilities = capabilities })
vim.lsp.config('dotls', { capabilities = capabilities })
vim.lsp.config('marksman', { capabilities = capabilities })
vim.lsp.config("markdown_oxide", {
  cmd = { "markdown-oxide" },
  filetypes = { "markdown" },
  root_markers = { ".git", ".obsidian" },
})

vim.lsp.enable("markdown_oxide")
vim.lsp.config('html', { capabilities = capabilities })
vim.lsp.config('elixirls', {
    cmd = { 'elixir-ls'},
})
vim.lsp.config('pylsp', { capabilities = capabilities })
vim.lsp.config('elp', {capabilities = capabilities, 
                        root_dir = vim.fn.getcwd()})
vim.lsp.config('jsonls', { capabilities = capabilities })
vim.lsp.config('bashls', { capabilities = capabilities })
vim.lsp.config('vimls', { capabilities = capabilities })

  -- ========================================================



-- mappings
--  Use LspAttach autocommand to only map the following keys
--  after the language server attaches to the current buffer
 vim.api.nvim_create_autocmd('LspAttach', {
 	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
 	callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        client.server_capabilities.semanticTokensProvider = nil
 		-- Enable completion triggered by <c-x><c-o>
 		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

 		-- Buffer local mappings.
 		-- See `:help vim.lsp.*` for documentation on any of the below functions
 		local opts = { buffer = ev.buf, remap = false }
 		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
 		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gp", function()
            vim.cmd("vsplit")
            vim.lsp.buf.definition()
        end, opts)
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

local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)

-- local on_attach = function(client, bufnr)
--   vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<M-;>', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<M-c>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
--   if client.server_capabilities.inlayHintProvider then
--     vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ih',
--       '<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>',
--       { noremap=true, silent=true, desc = '[T]oggle Inlay [H]ints' })
--   end
-- end



vim.lsp.enable('lua_ls')
vim.lsp.enable('nil_ls')
vim.lsp.enable('lemminx')
vim.lsp.enable('cssls')
vim.lsp.enable('clangd')
vim.lsp.enable('dotls')
vim.lsp.enable('marksman')
vim.lsp.enable('markdown_oxide')
vim.lsp.enable('html')
vim.lsp.enable('elp')
vim.lsp.enable('elixirls')
vim.lsp.enable('jsonls')
vim.lsp.enable('bashls')
vim.lsp.enable('vimls')
vim.lsp.enable('pylsp')


