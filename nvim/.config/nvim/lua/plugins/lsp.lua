return {
	{ "mason-org/mason.nvim", opts = {} },

	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		opts = {},
		config = function(_, opts)
			require("mason-lspconfig").setup(opts)

			-- override lua_ls BEFORE it starts
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
		end,
	},
}
