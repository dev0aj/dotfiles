return {
	{
		"stevearc/conform.nvim",
		dependencies = { "mason.nvim" },
		opts = {},
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					-- Conform will run multiple formatters sequentially
					go = function(bufnr)
						if require("conform").get_formatter_info("gofumpt", bufnr).available then
							return { "gofumpt" }
						else
							return { "gopls" }
						end
					end,
					-- You can customize some of the format options for the filetype (:help conform.format)
					rust = { "rustfmt", lsp_format = "fallback" },
					-- Conform will run the first available formatter
					javascript = { "prettierd", "prettier", stop_after_first = true },
					typescript = { "prettierd", "prettier", stop_after_first = true },
					javascriptreact = { "prettierd", "prettier", stop_after_first = true },
					typescriptreact = { "prettierd", "prettier", stop_after_first = true },
					css = { "prettierd", "prettier", stop_after_first = true },
					html = { "prettierd", "prettier", stop_after_first = true },
					json = { "prettierd", "prettier", stop_after_first = true },
					-- You can use a function here to determine the formatters dynamically
					python = function(bufnr)
						if require("conform").get_formatter_info("ruff_format", bufnr).available then
							return { "ruff_format" }
						else
							return { "isort", "black" }
						end
					end,
					-- Use the "*" filetype to run formatters on all filetypes.
					["*"] = { "codespell", "trim_whitespace" },
					-- Use the "_" filetype to run formatters on filetypes that don't
					-- have other formatters configured.
					["_"] = { "trim_whitespace" },
				},
			})
			vim.keymap.set("", "<leader>i", function()
				require("conform").format({ async = true, lsp_fallback = true })
			end)
		end,
	},
}
