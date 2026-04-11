return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		indent = {
			enabled = true,
			animate = { enabled = false },
		},
		input = { enabled = true },
		picker = {
			enabled = true,
			sources = {
				explorer = {
					auto_close = true,
					hidden = true,
					ignored = true,
					layout = { layout = { position = "right" } },
					win = {
						list = {
							keys = {
								["<ESC>"] = "",
							},
						},
					},
				},
				buffers = {
					finder = "buffers",
					format = "buffer",
					layout = {
						preview = false,
						preset = "ivy",
					},
					nofile = false,
					current = true,
					sort_lastused = true,
					win = {
						input = {
							keys = {
								["dd"] = { "bufdelete", mode = { "n" } },
								["<C-x>"] = { "bufdelete", mode = { "n" } },
							},
						},
					},
				},
			},
		},
		terminal = {
			enabled = true,
			win = { style = "float", border = "rounded", height = 0.8, width = 0.8 },
		},
	},
	keys = {
		-- terminal
		{
			"<c-p>",
			function()
				Snacks.terminal.toggle()
			end,
			mode = { "n", "t" },
		},
		{
			"<leader>ff",
			function()
				Snacks.picker.files()
			end,
			desc = "Find Files",
		},
		{
			"<leader>fa",
			function()
				Snacks.picker.files({
					hidden = true,
					ignored = true,
					exclude = { "**/.git/*" },
				})
			end,
			desc = "Find All Files",
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.git_status()
			end,
			desc = "Git Status",
		},
		{
			"<leader>fs",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "LSP Symbols",
		},
		-- search
		{
			"<leader>sg",
			function()
				Snacks.picker.grep()
			end,
			desc = "Live Grep",
		},
		{
			"<leader>sw",
			function()
				Snacks.picker.grep_word({ live = true })
			end,
			desc = "Grep word",
		},
		{
			"<leader>sb",
			function()
				Snacks.picker.grep_buffers()
			end,
			desc = "Grep Open Buffers",
		},
		-- Top Pickers & Explorer
		{
			"<leader><leader>",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>fr",
			function()
				Snacks.picker.resume()
			end,
			desc = "Resume",
		},
		{
			"<leader>fd",
			function()
				Snacks.picker.diagnostics_buffer()
			end,
			desc = "Buffer Diagnostics",
		},
		{
			"<leader>fD",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Diagnostics",
		},
		-- search
		{
			'<leader>f"',
			function()
				Snacks.picker.registers()
			end,
			desc = "Registers",
		},
		{
			"<leader>f/",
			function()
				Snacks.picker.search_history()
			end,
			desc = "Search History",
		},
		{
			"<leader>fj",
			function()
				Snacks.picker.jumps()
			end,
			desc = "Jumps",
		},
		{
			"<leader>fl",
			function()
				Snacks.picker.loclist()
			end,
			desc = "Location List",
		},
		{
			"<leader>fm",
			function()
				Snacks.picker.marks()
			end,
			desc = "Marks",
		},
		{
			"<leader>fq",
			function()
				Snacks.picker.qflist()
			end,
			desc = "Quickfix List",
		},
		{
			"<leader>fu",
			function()
				Snacks.picker.undo()
			end,
			desc = "Undo History",
		},
		-- LSP
		{
			"gd",
			function()
				Snacks.picker.lsp_definitions()
			end,
			desc = "Goto Definition",
		},
		{
			"gD",
			function()
				Snacks.picker.lsp_declarations()
			end,
			desc = "Goto Declaration",
		},
		{
			"gr",
			function()
				Snacks.picker.lsp_references()
			end,
			nowait = true,
			desc = "References",
		},
		{
			"gi",
			function()
				Snacks.picker.lsp_implementations()
			end,
			desc = "Goto Implementation",
		},
		{
			"gt",
			function()
				Snacks.picker.lsp_type_definitions()
			end,
			desc = "Goto T[y]pe Definition",
		},
		{
			"gai",
			function()
				Snacks.picker.lsp_incoming_calls()
			end,
			desc = "C[a]lls Incoming",
		},
		{
			"gao",
			function()
				Snacks.picker.lsp_outgoing_calls()
			end,
			desc = "C[a]lls Outgoing",
		},
	},
	init = function()
		vim.keymap.set("n", "<leader>e", function()
			local explorer_pickers = Snacks.picker.get({ source = "explorer" })
			if #explorer_pickers == 0 then
				Snacks.picker.explorer()
			elseif explorer_pickers[1]:is_focused() then
				explorer_pickers[1]:close()
			else
				explorer_pickers[1]:focus()
			end
		end)
	end,
}
