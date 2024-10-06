vim.api.nvim_create_autocmd("FileType", {
    pattern = "erlang",
    callback = function()
        vim.opt_local.conceallevel = 1  -- Set conceal level to 2
    end,
})

