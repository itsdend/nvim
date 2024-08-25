vim.g.mapleader = " "
--if vim.g.vscode then
--	--definitions
--	km.set("n", "gD", function() vim.fn.VSCodeNotify("editor.action.revealDefinitionAside") end)
--	--rename
--	km.set("n", "<leader>r", function() vim.fn.VSCodeNotify("editor.action.rename") end)
--	km.set("v", "<leader>r", function() vim.fn.VSCodeNotifyVisual("editor.action.selectHighlights", 1) end)
--	--vertical movement
--	km.set("n", "<leader>s", function() vim.fn.VSCodeNotify("workbench.action.files.save") end)

--	--select and debug
--	km.set("v", "<leader>d",
--		function()
--			vim.fn.VSCodeNotifyVisual("workbench.action.debug.selectandstart", 1)
--			vim.api.nvim_command("stopinsert")
--			vim.fn.VSCodeNotify("vscode-neovim.escape")
--		end)
--else
--	-- ordinary Neovim
--	require('settings_only_nvim')
--end

require('settings_only_nvim')

return require 'packer'.startup(function()
	use 'wbthomason/packer.nvim'
	use 'tpope/vim-surround'
	use 'tpope/vim-commentary'

	--use { "catppuccin/nvim", as = "catppuccin" }
	use {
		'nvim-treesitter/nvim-treesitter',
		run = function()
			local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
			ts_update()
		end,
	}
	require("plugins.treesitter")

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
		requires = {
			'nvim-tree/nvim-web-devicons',
			'yavorski/lualine-macro-recording.nvim',
			opt = true
		}
	}
	use {
		--"williamboman/mason.nvim",
		--"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	}

	use 'HiPhish/rainbow-delimiters.nvim'
	require("plugins.rainbow_delimiter")

	--smoothscroll
	use 'karb94/neoscroll.nvim'
	require('neoscroll').setup({
		performance_mode = true,
	})

	--toggle term
	use { "akinsho/toggleterm.nvim", tag = '*'
	}

	-- noice
	use 'MunifTanjim/nui.nvim'

	-- lazy.nvim
	use {
		"folke/noice.nvim",
		requires = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify"
		}
	}

	use { 'ThePrimeagen/harpoon', branch = 'harpoon2', }
	require("harpoon").setup()

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
	require("plugins.cmp_snip")

	use 'lewis6991/gitsigns.nvim'
	require("plugins.gitsigns")

	-- show colors behind the hex codes
	use 'NvChad/nvim-colorizer.lua'
	require 'colorizer'.setup()

	-- Packer
	use "sindrets/diffview.nvim"
	require 'diffview'.setup()

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


	use { "itsdend/pastel_inu_nvim", as = "catppuccin" }
	require("plugins.catppuccin")
	vim.cmd 'colorscheme catppuccin-mocha'

	use 'liuchengxu/graphviz.vim'
	vim.keymap.set('n', '<A-u>q', ': GraphvizCompile pdf<CR>', { noremap = true, silent = true })
	vim.keymap.set('n', '<A-u><A-q>', ': GraphvizCompile pdf<CR>', { noremap = true, silent = true })
end)
