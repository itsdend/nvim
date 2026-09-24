vim.g.mapleader = " "

require('settings_only_nvim')

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    'tpope/vim-surround',
    'tpope/vim-commentary',

    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'master',
        build = ':TSUpdate',
        config = function()
            require("plugins.treesitter")
        end,
    },

    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
    },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'yavorski/lualine-macro-recording.nvim',
        },
    },

    'neovim/nvim-lspconfig',

    {
        'HiPhish/rainbow-delimiters.nvim',
        config = function()
            require("plugins.rainbow_delimiter")
        end,
    },

    {
        'karb94/neoscroll.nvim',
        config = function()
            require('neoscroll').setup({ performance_mode = true })
        end,
    },

    { "akinsho/toggleterm.nvim", version = '*' },

    {
        'ryanmsnyder/toggleterm-manager.nvim',
        dependencies = {
            'akinsho/toggleterm.nvim',
            'nvim-telescope/telescope.nvim',
            'nvim-lua/plenary.nvim',
        },
    },

    'MunifTanjim/nui.nvim',

    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
    },

    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        config = function()
            require("harpoon").setup()
        end,
    },

    {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup {}
            local npairs = require('nvim-autopairs')
            local Rule = require('nvim-autopairs.rule')
            npairs.add_rule(Rule('<<', '>>', { 'erlang' }))
        end,
    },

    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'rafamadriz/friendly-snippets',

    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
        },
        config = function()
            require("plugins.cmp_snip")
        end,
    },

    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require("plugins.gitsigns")
        end,
    },

    {
        'NvChad/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()
        end,
    },

    'sindrets/diffview.nvim',

    {
        'jiaoshijie/undotree',
        dependencies = 'nvim-lua/plenary.nvim',
    },

    {
        url = 'https://codeberg.org/andyg/leap.nvim',
        dependencies = 'tpope/vim-repeat',
    },

    {
        'itsdend/pastel_inu_nvim',
        name = 'catppuccin',
        lazy = false,
        priority = 1000,
        config = function()
            require("plugins.catppuccin")
            vim.cmd 'colorscheme catppuccin-mocha'
        end,
    },

    {
        'liuchengxu/graphviz.vim',
        config = function()
            vim.keymap.set('n', '<A-u>q', ':GraphvizCompile pdf<CR>', { noremap = true, silent = true })
            vim.keymap.set('n', '<A-u><A-q>', ':GraphvizCompile pdf<CR>', { noremap = true, silent = true })
        end,
    },

}, {
    defaults = { lazy = false },
})
