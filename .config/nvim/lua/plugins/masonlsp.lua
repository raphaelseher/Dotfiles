return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason-lspconfig.nvim" },
			{
				"williamboman/mason.nvim",
				opts = {
					ensure_installed = {
						"stylua",
						"shellcheck",
						"shfmt",
					},
				},
			},
		},
		opts = {
			ensure_installed = {
				"lua_ls",
				"dockerls",
				"html",
				-- "phpactor",
				"intelephense",
				"jsonls",
				"tsserver",
				"clangd",
				-- "gopls",
			},
		},
		config = function()
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({})
				end,
				["intelephense"] = function()
					require("lspconfig").intelephense.setup({
						on_attach = function(client)
							client.server_capabilities.renameProvider = true
							client.server_capabilities.definitionProvider = true
						end,
						settings = {
							intelephense = {
								files = {
									maxSize = 1000000,
								},
								environment = {
									includePaths = {
										"*/tmp/cache/**",
										"*/tmp/**",
									},
								},
							},
						},
					})
				end,
				["phpactor"] = function()
					require("lspconfig").phpactor.setup({
						init_options = {
							["indexer.exclude_patterns"] = {
								"*/cache/*",
							},
						},
						on_attach = function(client)
							client.server_capabilities.completionProvider = false
							client.server_capabilities.hoverProvider = false
							client.server_capabilities.definitionProvider = false
							client.server_capabilities.renameProvider = false
						end,
					})
				end,
				["lua_ls"] = function()
					require("lspconfig").lua_ls.setup({
						settings = {
							Lua = {
								runtime = {
									version = "LuaJIT",
									path = vim.split(package.path, ";"),
								},
								diagnostics = {
									enable = false,
									globals = {
										"vim",
										"require",
									},
								},
							},
						},
					})
				end,
			})
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		opts = {
			automatic_setup = true,
			ensure_installed = {
				"codelldb",
				"node2",
				"php-debug-adapter",
			},
		},
	},
}
