return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },            -- if you use the mini.nvim suite
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
	},
	{
		"zk-org/zk-nvim",
		name = "zk",
		config = function()
			require("zk").setup({
				lsp = {
					-- `config` is passed to `vim.lsp.start(config)`
					config = {
						name = "zk",
						cmd = { "zk", "lsp" },
						filetypes = { "markdown" },
						-- on_attach = ...
						-- etc, see `:h vim.lsp.start()`
					},

					-- automatically attach buffers in a zk notebook that match the given filetypes
					auto_attach = {
						enabled = true,
					},
				},
				picker_options = {
					snacks_picker = {
						layout = {
							preset = "ivy",
						},
					},
				},
			})

			local opts = { noremap = true, silent = false }

			-- index the notebook
			vim.api.nvim_set_keymap("n", "<leader>zI", "<Cmd>ZkIndex<CR>", opts)

			-- Create a new note after asking for its title.
			vim.api.nvim_set_keymap("n", "<leader>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", opts)

			-- Create a new note with selection as title
			vim.api.nvim_set_keymap("v", "<leader>zv", ":ZkNewFromTitleSelection<CR>", opts)

			-- Open notes associated with the selected tags.
			vim.api.nvim_set_keymap("n", "<leader>zt", "<Cmd>ZkTags<CR>", opts)

			-- forward links
			vim.api.nvim_set_keymap("n", "<leader>zl", "<Cmd>ZkLinks<CR>", opts)

			-- back link
			vim.api.nvim_set_keymap("n", "<leader>zb", "<Cmd>ZkBacklinks<CR>", opts)

			-- Search for the notes
			vim.api.nvim_set_keymap("n", "<leader>zf", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", opts)

			-- Search for the notes matching the current visual selection.
			vim.api.nvim_set_keymap("v", "<leader>zf", ":'<,'>ZkMatch<CR>", opts)

			-- open daily note
			vim.api.nvim_set_keymap("n", "<leader>zd", '<cmd>ZkNew { dir = "daily", date = "today" }<cr>', opts)
		end,
	},
}
