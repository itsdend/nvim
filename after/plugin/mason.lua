--require('mason').setup {

--}
--require('mason-lspconfig').setup {
--	ensure_installed = { "lua_ls", "erlangls", "jsonls", "bashls", "vimls", "elixirls", "html", "marksman", "dotls", "clangd", "cssls", "lemminx"}
--}

-- =================MUST=====================================
local util = require("lspconfig.util")
--
-- OVO je original
--
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
--
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.workspace = {
    didChangeWatchedFiles = {
        dynamicRegistration = true
    }
}

require('lspconfig').lua_ls.setup { capabilities = capabilities }
require('lspconfig').nil_ls.setup { capabilities = capabilities }
require('lspconfig').lemminx.setup { capabilities = capabilities }
require('lspconfig').cssls.setup { capabilities = capabilities }
require('lspconfig').clangd.setup { capabilities = capabilities }
require('lspconfig').dotls.setup { capabilities = capabilities }
require('lspconfig').marksman.setup { capabilities = capabilities }
require('lspconfig').html.setup { capabilities = capabilities }
-- require('lspconfig').erlangls.setup { capabilities = capabilities }
-- require('lspconfig').elp.setup { capabilities = capabilities}

--   root_dir = function(fname)
--     return util.root_pattern("rebar.config")(fname)
--       or util.find_git_ancestor(fname)
--   end,

--   single_file_support = false,
-- })
require('lspconfig').elixirls.setup { capabilities = capabilities }
require('lspconfig').jsonls.setup { capabilities = capabilities }
require('lspconfig').bashls.setup { capabilities = capabilities }
require('lspconfig').vimls.setup { capabilities = capabilities }
require('lspconfig').pylsp.setup { capabilities = capabilities}
-- vim.lsp.config('lua_ls', { capabilities = capabilities })
-- vim.lsp.config('nil_ls', { capabilities = capabilities })
-- vim.lsp.config('lemminx', { capabilities = capabilities })
-- vim.lsp.config('cssls', { capabilities = capabilities })
-- vim.lsp.config('clangd', { capabilities = capabilities })
-- vim.lsp.config('dotls', { capabilities = capabilities })
-- vim.lsp.config('marksman', { capabilities = capabilities })
-- vim.lsp.config('html', { capabilities = capabilities })
--
-- OVO za elp radi
vim.lsp.config('erlangls', {capabilities = capabilities, 
root_dir = vim.fn.getcwd()})
-- do tud je fixan dio s masovnim stvaranjem elp klijenata


--   capabilities = vim.tbl_deep_extend("force", capabilities, {
--     textDocument = {
-- semanticTokens = {
--           augmentsSyntaxTokens = false,
--           dynamicRegistration = false,
--           formats = { "relative" },
--           multilineTokenSupport = false,
--           overlappingTokenSupport = false,
--           requests = {
--             full = false,
--             range = false
--           },
--           serverCancelSupport = true,
--           tokenModifiers = {},
--           tokenTypes = {}
--         }
--     },
--   }),
-- })
  -- root_dir = function(bufnr, on_dir)
  --   -- get filename from buffer
  --   local fname = vim.api.nvim_buf_get_name(bufnr)

  --   -- ignore nix store files
  --   if fname:match("^/nix/store/") then
  --     on_dir(vim.loop.cwd())
  --     return
  --   end

  --   -- find project root using standard markers
  --   local root = util.root_pattern("rebar.config", "erlang.mk", ".git")(fname)
  --     or util.find_git_ancestor(fname)

  --   if root then
  --     on_dir(root)  -- start LSP with this root
  --   else
  --     on_dir(vim.loop.cwd())  -- fallback
  --   end
  -- end,
  -- ========================================================
 -- root_dir = function(bufnr, on_dir)
 --    local fname = vim.api.nvim_buf_get_name(bufnr)
 --    if fname == "" then return end

 --    -- ignore nix store
 --    if fname:match("^/nix/store/") then
 --      on_dir(vim.loop.cwd())
 --      return
 --    end

 --    -- search for all rebar.config files upwards
 --    local dirs = util.search_ancestors(fname, function(path)
 --      if vim.fn.filereadable(path .. "/rebar.config") == 1 then
 --        return path
 --      end
 --    end)

 --    local root
 --    if #dirs > 0 then
 --      -- nearest rebar.config → app root
 --      root = dirs[#dirs]
 --    else
 --      -- fallback to umbrella or git ancestor
 --      root = util.find_git_ancestor(fname) or vim.loop.cwd()
 --    end

 --    on_dir(root)
 --  end,
						-- settings = {

						-- 	elp = {
						-- 		diagnostics = {
						-- 			disabled = {
						-- 				"L0002"
						-- 			}
						-- 		}
						-- 	}
						-- }
					-- })
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



-- vim.lsp.enable('lua_ls')
-- vim.lsp.enable('nil_ls')
-- vim.lsp.enable('lemminx')
-- vim.lsp.enable('cssls')
-- vim.lsp.enable('clangd')
-- vim.lsp.enable('dotls')
-- vim.lsp.enable('marksman')
-- vim.lsp.enable('html')
-- vim.lsp.enable('elp')
vim.lsp.enable('erlangls')
-- vim.lsp.enable('elixirls')
-- vim.lsp.enable('jsonls')
-- vim.lsp.enable('bashls')
-- vim.lsp.enable('vimls')


