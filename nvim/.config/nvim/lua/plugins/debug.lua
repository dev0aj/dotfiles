return {
	"mfussenegger/nvim-dap",
	event = "VeryLazy",
	dependencies = {
		"igorlfs/nvim-dap-view",
		"jay-babu/mason-nvim-dap.nvim",
		"theHamsta/nvim-dap-virtual-text",
	},
	config = function()
		local dap = require("dap")
		local mason_dap = require("mason-nvim-dap")
		local dap_view = require("dap-view")
		local dap_vt = require("nvim-dap-virtual-text")

		dap_vt.setup()

		-- Mason DAP
		mason_dap.setup({

			ensure_installed = { "go", "python" },
			automatic_installation = true,
			handlers = {
				function(config)
					mason_dap.default_setup(config)
				end,
			},
		})

		-- Python Path
		local function python_path()
			if os.getenv("VIRTUAL_ENV") then
				return os.getenv("VIRTUAL_ENV") .. "/bin/python"
			end

			local venv = vim.fn.getcwd() .. "/.venv/bin/python"
			if vim.fn.executable(venv) == 1 then
				return venv
			end

			return vim.fn.exepath("python3") or "/usr/bin/python3"
		end

		-- Python Configurations
		dap.configurations.python = {
			{
				name = "Python: Current File",
				type = "python",
				request = "launch",
				program = "${file}",
				pythonPath = python_path,
			},

			{
				name = "Python: Module",
				type = "python",
				request = "launch",
				module = function()
					return vim.fn.input("Module name: ")
				end,
				pythonPath = python_path,
			},
		}

		dap.configurations.go = {
			{
				name = "Go: Debug File",
				type = "go",
				request = "launch",
				program = "${file}",
			},

			{
				name = "Go: Debug Package",
				type = "go",
				request = "launch",
				program = "${fileDirname}",
			},

			{
				name = "Go: Debug Test",
				type = "go",
				request = "launch",
				mode = "test",
				program = "${file}",
			},
		}

		-- dap-view
		dap_view.setup()

		local dap_views = {
			W = "watches",
			S = "scopes",
			E = "exceptions",
			B = "breakpoints",
			T = "threads",
			R = "repl",
		}

		local function set_dap_keymaps()
			for key, view in pairs(dap_views) do
				vim.keymap.set("n", key, function()
					dap_view.jump_to_view(view)
				end, { buffer = true })
			end
		end

		local function remove_dap_keymaps()
			for key, _ in pairs(dap_views) do
				pcall(vim.keymap.del, "n", key, { buffer = true })
			end
		end

		-- dap listeners
		local function open_ui()
			dap_view.open()
			set_dap_keymaps()
		end

		local function close_ui()
			dap_view.close()
			remove_dap_keymaps()
		end

		dap.listeners.before.attach.dapui_config = open_ui
		dap.listeners.before.launch.dapui_config = open_ui
		dap.listeners.before.event_terminated.dapui_config = close_ui
		dap.listeners.before.event_exited.dapui_config = close_ui

		-- Signs
		vim.fn.sign_define("DapBreakpoint", {
			text = "🐞",
			texthl = "DiagnosticSignError",
		})

		-- Keymaps
		local map = vim.keymap.set

		map("n", "<leader>dp", function()
			vim.cmd("DapNew")
		end)
		map("n", "<leader>dt", dap.toggle_breakpoint)
		map("n", "<leader>dn", dap.continue)

		-- step controls
		map("n", "<leader>ds", dap.step_over) -- step over
		map("n", "<leader>di", dap.step_into) -- step into
		map("n", "<leader>do", dap.step_out) -- step out

		map("n", "<leader>dq", function()
			dap.terminate()
		end)

		map("n", "<leader>db", dap.list_breakpoints)
	end,
}
