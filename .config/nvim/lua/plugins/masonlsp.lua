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
				"phpactor",
				"jsonls",
				"tsserver",
				"clangd",
				"gopls",
			},
		},
		config = function()
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({})
				end,
				["phpactor"] = function()
					require("lspconfig").phpactor.setup({
						cmd = { "phpactor", "language-server", "-vvv" },
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
