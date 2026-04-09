return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"williamboman/mason-lspconfig.nvim",
				opts = {
					ensure_installed = {
						"lua_ls",
						"dockerls",
						"html",
						"phpactor",
						"intelephense",
						"jsonls",
						"clangd",
						-- "gopls",
					},
					automatic_enable = true,
				},
			},
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
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup()

			-- clangd with custom cmd and root_dir
			vim.lsp.config("clangd", {
				cmd = { "clangd", "--background-index", "--clang-tidy" },
				root_markers = { "compile_commands.json", ".git" },
			})

			-- intelephense
			vim.lsp.config("intelephense", {
				on_attach = function(client)
					client.server_capabilities.renameProvider = true
					client.server_capabilities.definitionProvider = true
				end,
				settings = {
					intelephense = {
						files = { maxSize = 1000000 },
						environment = {
							includePaths = { "*/tmp/cache/**", "*/tmp/**" },
						},
					},
				},
			})

			-- phpactor
			vim.lsp.config("phpactor", {
				init_options = {
					["indexer.exclude_patterns"] = { "*/cache/*" },
				},
				on_attach = function(client)
					client.server_capabilities.completionProvider = false
					client.server_capabilities.hoverProvider = false
					client.server_capabilities.definitionProvider = false
					client.server_capabilities.renameProvider = false
				end,
			})

			-- lua_ls
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
							path = vim.split(package.path, ";"),
						},
						diagnostics = {
							enable = false,
							globals = { "vim", "require" },
						},
					},
				},
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
