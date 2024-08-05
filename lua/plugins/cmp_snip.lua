local cmp_icons = {
	Function = "󰮃",
	Text = "󰊄",
	Snippet = "󰂾",
	Method = "",
	Variable = "",
	TypeParameter = "󰼭",
	Module = "󰣩",
	Constant = "󰔎",
	Class = "󰔫",
	Keyword = "󰷖",
	Field = "󰠴"
}

local cmp = require 'cmp'
cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		require("luasnip.loaders.from_vscode").load({ paths = { "./vscode_snippets" } }),
		require("luasnip.loaders.from_vscode").load(),
		expand = function(args)
			require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	completion = {
		completeopt = 'menu,menuone,noinsert'
	},
	window = {
		completion = cmp.config.window.bordered(),
		comleteopt = 'menu, menuone, noinsert',
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<M-S-y>'] = cmp.mapping.scroll_docs(-4),
		['<M-y>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(_, vim_item)
			local kind = vim_item.kind
			vim_item.kind = (cmp_icons[kind] or "󱧤") .. " "
			vim_item.menu = " " .. kind .. " "
			return vim_item
		end
	},
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' }, -- For luasnip users.
	}, {
		{ name = 'buffer' },
	}),
	event = 'InsertEnter',
})

local luasnip = require("luasnip")
vim.keymap.set('i', '<C-k>', "<Plug>luasnip-expand-or-jump", { silent = true })

vim.keymap.set({ "i", "s" }, "<C-L>", "<cmd>lua require('luasnip').jump(1)<CR>", { silent = true })
vim.keymap.set({ "i", "s" }, "<C-H>", "<cmd>lua require('luasnip').jump(-1)<CR>", { silent = true })

vim.keymap.set({ "i", "s" }, "<C-%>", function()
	if luasnip.choice_active() then
		luasnip.change_choice(1)
	end
end, { silent = true })
