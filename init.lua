local set = vim.opt
local km = vim.keymap
vim.g.mapleader = " "
if vim.g.vscode then
	--definitions
	km.set("n", "gD", function() vim.fn.VSCodeNotify("editor.action.revealDefinitionAside") end)
	--rename
	km.set("n", "<leader>r", function() vim.fn.VSCodeNotify("editor.action.rename") end)
	km.set("v", "<leader>r", function() vim.fn.VSCodeNotifyVisual("editor.action.selectHighlights", 1) end)
	--vertical movement
	km.set("n", "<leader>s", function() vim.fn.VSCodeNotify("workbench.action.files.save") end)

	--select and debug
	km.set("v", "<leader>d",
		function()
			vim.fn.VSCodeNotifyVisual("workbench.action.debug.selectandstart", 1)
			vim.api.nvim_command("stopinsert")
			vim.fn.VSCodeNotify("vscode-neovim.escape")
		end)
else
	-- ordinary Neovim
	require('settings')
end
set.incsearch = true
set.hlsearch = false
set.fileencoding = 'utf-8'
vim.keymap.set("n", "<C-d>", '<C-d>zz', { noremap = true })
vim.keymap.set("n", "<C-u>", '<C-u>zz', { noremap = true })
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>p", 'o<CR>"+p')
vim.keymap.set({ "n", "v" }, '~', '$', { noremap = true })
vim.keymap.set({ "n", "v" }, '&', '~', { noremap = true })
set.expandtab = false
--indenting and outdenting
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true })
vim.keymap.set('i', 'kj', '<Esc>', { noremap = true })


return require 'packer'.startup(function()
	use 'wbthomason/packer.nvim'
	use 'tpope/vim-surround'
	use 'tpope/vim-commentary'

	if vim.g.vscode then
		-- nothing
	else
		vim.opt.cursorline = true
		vim.cmd('syntax enable')
		vim.cmd('syntax on')
		--use { "catppuccin/nvim", as = "catppuccin" }
		use {
			'nvim-treesitter/nvim-treesitter',
			run = function()
				local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
				ts_update()
			end,
		}

		use('nvim-treesitter/playground')
		use {
			'nvim-telescope/telescope.nvim', tag = '0.1.5',
			-- or                            , branch = '0.1.x',
			requires = { { 'nvim-lua/plenary.nvim' } }
		}
		use {
			"nvim-neo-tree/neo-tree.nvim",
			branch = "v3.x",
			requires = {
				"nvim-lua/plenary.nvim",
				"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
				"MunifTanjim/nui.nvim",
			}
		}
		use {
			'nvim-lualine/lualine.nvim',
			requires = { 'nvim-tree/nvim-web-devicons', opt = true }
		}
		use {
			--"williamboman/mason.nvim",
			--"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
		}

		use 'HiPhish/rainbow-delimiters.nvim'
		-- This module contains a number of default definitions
		local rainbow_delimiters = require 'rainbow-delimiters'

		vim.g.rainbow_delimiters = {
			strategy = {
				[''] = rainbow_delimiters.strategy['global'],
				erlang = rainbow_delimiters.strategy['global']
			},
			query = {
				[''] = 'rainbow-delimiters',
			},
			priority = {
				[''] = 510,
			},
			highlight = {
			},
		}

		vim.opt.fillchars = { eob = " " }

		-- neotree
		vim.keymap.set("n", "<A-u>e", ":Neotree filesystem reveal right toggle<CR>",
			{ noremap = true, silent = true })
		vim.keymap.set("n", "<A-u><A-e>", ":Neotree filesystem reveal right toggle<CR>",
			{ noremap = true, silent = true })
		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				vim.cmd(":Neotree right")
				-- vim.cmd(':wincmd h')  --start on the focus right
			end,
		})

		--smoothscroll
		use 'karb94/neoscroll.nvim'
		require('neoscroll').setup({
			performance_mode = true,
		})

		--toggle term
		use { "akinsho/toggleterm.nvim", tag = '*', config = function()
			require("toggleterm").setup({
				open_mapping = [[<A-t>t]],
				insert_mappings = true,
				terminal_mappings = true,
				direction = "float",
				close_on_exit = false,
				config = true
			})
		end }
		vim.keymap.set({ 'n', 't', 'i' }, '<A-t>t', ':lua require"toggleterm".toggle()<CR>',
			{ noremap = true, silent = true })

		local Terminal = require("toggleterm.terminal").Terminal

		local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
		function LAZYGIT_TOGGLE()
			lazygit:toggle()
		end

		-- Define a custom command to toggle lazygit
		vim.cmd("command! LazygitToggle lua LAZYGIT_TOGGLE()")

		-- Now, you can call the command ':LazygitToggle' in command mode to toggle lazygit


		-- noice
		use 'MunifTanjim/nui.nvim'
		-- lazy.nvim
		use {
			"folke/noice.nvim",
			requires = {
				"MunifTanjim/nui.nvim",
				"rcarriga/nvim-notify"
			},
			config = function()
				require("noice").setup({
					messages = {
						enabled = true,
						view = "mini", -- default view for messages
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
						bottom_search = false, -- use a classic bottom cmdline for search
						command_palette = true, -- position the cmdline and popupmenu together
						long_message_to_split = true, -- long messages will be sent to a split
						inc_rename = false, -- enables an input dialog for inc-rename.nvim
						lsp_doc_border = false, -- add a border to hover docs and signature help
					},
					routes = {
						{
							filter = {
								event = "msg_show",
								kind = "",
								find = "written",
							},
							opts = { skip = true },
						},
					}
				})
			end
		}
		vim.keymap.set('n', '<M-i>n', ': NoiceDismiss<CR>', { noremap = true, silent = true })

		use 'Asheq/close-buffers.vim'
		vim.keymap.set('n', '<M-i>r', ':Bdelete other<CR>', { noremap = true, silent = true })

		use { 'ThePrimeagen/harpoon', branch = 'harpoon2', }

		vim.keymap.set("n", "<A-i>f", ":Neotree close<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<A-i><A-f>", ":Neotree close<CR>", { noremap = true, silent = true })
		vim.keymap.set({ 'n', 'v', 'i' }, '<A-s>', '<cmd> w<CR>', { noremap = true, silent = true })

		--autopair parenthesis
		use {
			'windwp/nvim-autopairs',
			config = function()
				require('nvim-autopairs').setup {}
			end
		}
		--luasnip
		use 'L3MON4D3/LuaSnip'
		use 'saadparwaiz1/cmp_luasnip'
		use "rafamadriz/friendly-snippets"

		--autocomplete
		use 'hrsh7th/nvim-cmp'
		use 'hrsh7th/cmp-nvim-lsp'
		use 'hrsh7th/cmp-buffer'

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
				fields = {"kind", "abbr", "menu"},
				format = function (_, vim_item)
					local kind = vim_item.kind
					vim_item.kind =  (cmp_icons[kind] or "󱧤") .. " "
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

		use 'lewis6991/gitsigns.nvim'
		require('gitsigns').setup {
			signs                        = {
				add          = { text = '│' },
				change       = { text = '│' },
				delete       = { text = '_' },
				topdelete    = { text = '‾' },
				changedelete = { text = '~' },
				untracked    = { text = '┆' },
			},
			signcolumn                   = true, -- Toggle with `:Gitsigns toggle_signs`
			numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
			linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
			watch_gitdir                 = {
				follow_files = true
			},
			auto_attach                  = true,
			attach_to_untracked          = false,
			current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_opts      = {
				virt_text = true,
				virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
				delay = 1000,
				ignore_whitespace = false,
				virt_text_priority = 100,
			},
			current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
			sign_priority                = 6,
			update_debounce              = 100,
			status_formatter             = nil, -- Use default
			max_file_length              = 40000, -- Disable  file is longer than this (in lines)
			preview_config               = {
				-- Options passed to nvim_open_win
				border = 'single',
				style = 'minimal',
				relative = 'cursor',
				row = 0,
				col = 1
			},
			yadm                         = {
				enable = false
			},
		}
		-- show colors behind the hex codes
		use 'NvChad/nvim-colorizer.lua'
		require 'colorizer'.setup()


		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalSB", { bg = "none" })
		vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

		use 'liuchengxu/graphviz.vim'
		vim.keymap.set('n', '<A-u>q', ': GraphvizCompile pdf<CR>', { noremap = true, silent = true })
		vim.keymap.set('n', '<A-u><A-q>', ': GraphvizCompile pdf<CR>', { noremap = true, silent = true })
		-- Packer
		use "sindrets/diffview.nvim"
		require 'diffview'.setup()
		vim.keymap.set('n', '<A-g>o', ': DiffviewOpen<CR>', { noremap = true, silent = true })
		vim.keymap.set('n', '<A-g>c', ': DiffviewClose<CR>', { noremap = true, silent = true })
		vim.keymap.set('n', '<A-g>r', ': DiffviewRefresh<CR>', { noremap = true, silent = true })

		-- undotree
		use { 'jiaoshijie/undotree',
			requires = "nvim-lua/plenary.nvim"
		}
		require('undotree').setup()
		vim.keymap.set('n', '<leader>u', require('undotree').toggle, { noremap = true, silent = true })

		use { 'ggandor/leap.nvim',
			requires = 'tpope/vim-repeat'
		}
		require('leap').create_default_mappings()

		km.set("n", "<leader>b", vim.cmd.Ex)
		use { "itsdend/pastel_inu_nvim", as = "catppuccin" }
		require("catppuccin").setup({
			transparent_background = true,
			integrations = {
				neotree = true,
				treesitter = true,
				rainbow_delimiters = true,
				gitsigns = true
			}
		})
		vim.cmd 'colorscheme catppuccin-mocha'
	end
end)
