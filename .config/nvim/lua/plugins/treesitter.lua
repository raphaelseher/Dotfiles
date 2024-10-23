return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = {
					"c",
					"lua",
					"vim",
					"vimdoc",
					"cpp",
					"css",
					"html",
					"typescript",
					"javascript",
					"go",
					"php",
					"sql",
				},
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
				disable = function(lang, bufnr)
					return api.nvim_buf_line_count(bufnr) > 10000
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			enable = true,
			max_lines = 1,
			multiline_threshold = 2,
		},
	},
}
