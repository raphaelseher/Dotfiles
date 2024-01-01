return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			dapui.setup()

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			dap.adapters.php = {
				type = "executable",
				command = "sh",
				args = { os.getenv("HOME") .. "/.local/share/nvim/mason/bin/php-debug-adapter" },
			}

			dap.configurations.php = {
				{
					type = "php",
					request = "launch",
					name = "Listen for Xdebug",
					port = 9003,
					stopOnEntry = false,
					-- needed for php debug in docker
					-- pathMappings = {
					-- 	["/var/www/html"] = "${workspaceFolder}",
					-- },
				},
			}

			dap.configurations.lua = {
				{
					type = "nlua",
					request = "attach",
					name = "Attach to running Neovim instance",
				},
			}

			dap.configurations.cpp = {
				name = "Launch lldb",
				type = "lldb", -- matches the adapter
				request = "launch", -- could also attach to a currently running process
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = {},
				runInTerminal = false,
			}

			dap.adapters.nlua = function(callback, config)
				callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
			end
		end,
	},
	{ "rcarriga/nvim-dap-ui" },
	{ "jbyuki/one-small-step-for-vimkind" },
}
