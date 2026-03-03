return {
    "danymat/neogen",
    config = function ()
        require("neogen").setup({})

        local opts = { noremap = true, silent = true }
        vim.keymap.set({"n"}, "<leader>nc", ":lua require('neogen').generate({ type = 'class' })<CR>", opts)
        vim.keymap.set({"n"}, "<leader>nf", ":lua require('neogen').generate({ type = 'func' })<CR>", opts)
    end
}
