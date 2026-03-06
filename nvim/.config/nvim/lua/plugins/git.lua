return {
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required

			"sindrets/diffview.nvim", -- optional
			"folke/snacks.nvim", -- optional
		},
		config = function()
			local neogit = require("neogit")
			neogit.setup({
				commit_editor = {
					kind = "split",
					show_staged_diff = false,
					staged_diff_split_kind = "vsplit",
				},
			})

			vim.keymap.set("n", "<leader>hv", function()
				neogit.open({ kind = "vsplit" })
			end, { desc = "Open Neogit in vertical split" })

			local diffview = require("diffview")
			local actions = require("diffview.actions")

			vim.keymap.set("n", "<leader>hd", "<cmd>DiffviewOpen<cr>", { desc = "open diffview" })
			vim.keymap.set("n", "<leader>hf", "<cmd>DiffviewFileHistory --follow %", { desc = "File history" })
			vim.keymap.set("n", "<leader>hq", "<cmd>DiffviewClose<cr>", { desc = "close diffview" })

			diffview.setup({
				enhanced_diff_hl = true,
				view = {
					default = {
						disable_diagnostics = true,
					},
					merge_tool = {
						-- Available layouts:
						--  'diff1_plain'
						--    |'diff2_horizontal'
						--    |'diff2_vertical'
						--    |'diff3_horizontal'
						--    |'diff3_vertical'
						--    |'diff3_mixed'
						--    |'diff4_mixed'
						layout = "diff1_plain",
						-- layout = "diff3_mixed",
						-- layout = "diff4_mixed",
					},
				},
				file_panel = {
					win_config = {
						position = "right",
					},
				},
				keymaps = {
					disable_defaults = false,
					view = {
						-- File panel
						{ "n", "<leader>e", actions.toggle_files, { desc = "Toggle file panel" } },

						-- Hunk navigation
						{ "n", "]c", actions.next_conflict, { desc = "Next Conflict" } },
						{ "n", "[c", actions.prev_conflict, { desc = "Prev Conflict" } },

						-- open commit log
						{ "n", "L", actions.open_commit_log, { desc = "Focus file panel" } },

						-- Conflict resolution
						{ "n", "co", actions.conflict_choose("ours"), { desc = "Choose ours" } },
						{ "n", "ct", actions.conflict_choose("theirs"), { desc = "Choose theirs" } },
						{ "n", "cb", actions.conflict_choose("base"), { desc = "Choose base" } },
						{ "n", "ca", actions.conflict_choose("all"), { desc = "Choose both" } },

						-- Apply to all conflicts
						{ "n", "Co", actions.conflict_choose_all("ours"), { desc = "All ours" } },
						{ "n", "Ct", actions.conflict_choose_all("theirs"), { desc = "All theirs" } },
						{ "n", "Cb", actions.conflict_choose_all("base"), { desc = "Choose base" } },
						{ "n", "Ca", actions.conflict_choose_all("all"), { desc = "Choose both" } },
					},
					file_panel = {
						{ "n", "<leader>e", actions.toggle_files, { desc = "Toggle file panel" } },
						{ "n", "<cr>", actions.select_entry, { desc = "Open the diff for the selected entry" } },
						{ "n", "s", actions.toggle_stage_entry, { desc = "Stage/unstage the selected entry" } },
						{ "n", "S", actions.stage_all, { desc = "Stage all entries" } },
						{ "n", "U", actions.unstage_all, { desc = "Unstage all entries" } },
					},
				},
			})
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		---@module 'gitsigns'
		---@type Gitsigns.Config
		---@diagnostic disable-next-line: missing-fields
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "┃" },
					change = { text = "┃" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},
				signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
				numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
				current_line_blame = false,
				current_line_blame_opts = {
					virt_text = true,
					-- "eol" | "overlay" | "right_align"
					virt_text_pos = "eol",
					delay = 500,
					ignore_whitespace = false,
					virt_text_priority = 100,
				},
				current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
			})

			local gs = package.loaded.gitsigns
			-- Navigation
			vim.keymap.set("n", "]g", function()
				if vim.wo.diff then
					return "]g"
				end
				vim.schedule(function()
					gs.next_hunk()
				end)
				return "<Ignore>"
			end, { expr = true })

			vim.keymap.set("n", "[g", function()
				if vim.wo.diff then
					return "[g"
				end
				vim.schedule(function()
					gs.prev_hunk()
				end)
				return "<Ignore>"
			end, { expr = true })

			-- Actions
			vim.keymap.set("n", "<leader>ha", gs.stage_hunk)
			vim.keymap.set("n", "<leader>hA", gs.stage_buffer)
			vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk)
			vim.keymap.set("n", "<leader>hr", gs.reset_hunk)
			vim.keymap.set("n", "<leader>hR", gs.reset_buffer)
			vim.keymap.set("n", "<leader>hp", "<Cmd>Gitsigns preview_hunk_inline<CR>", {})
			vim.keymap.set("n", "<leader>hb", gs.toggle_current_line_blame, {})
		end,
	},
}
