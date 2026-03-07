return {
	"saghen/blink.cmp",
	-- dependencies = 'rafamadriz/friendly-snippets',
	version = "1.*",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		appearance = {
			nerd_font_variant = "mono",
		},
		-- completion = {
		-- 	documentation = {
		-- 		auto_show = true,
		-- 		auto_show_delay_ms = 250,
		-- 		treesitter_highlighting = true,
		-- 		window = { border = "rounded" },
		-- 	},
		-- },
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
		list = {
			selection = {
				preselect = false,
				auto_insert = false,
			},
		},
		signature = { enabled = true },

		keymap = {
			["<C-k>"] = { "show", "show_documentation", "hide_documentation" },
		},
	},

	opts_extend = { "sources.default" },
}
