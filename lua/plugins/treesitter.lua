require('nvim-treesitter.configs').setup {
    ensure_installed = { "nix", "c", "lua", "vim", "vimdoc", "elixir", "regex", "bash", "markdown", "markdown_inline", "erlang" },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

vim.keymap.set("n", "<leader>m", ':InspectTree<CR>', { noremap = true })
