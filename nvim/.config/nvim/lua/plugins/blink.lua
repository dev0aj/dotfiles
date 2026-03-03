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
		completion = {
			documentation = {
				auto_show = true,
			},
		},
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
	},

	opts_extend = { "sources.default" },
}
