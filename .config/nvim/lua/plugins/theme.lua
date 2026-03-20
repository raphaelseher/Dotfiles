return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			-- vim.cmd("colorscheme catppuccin-mocha")
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		config = function()
			vim.cmd("syntax enable")
			--vim.cmd("colorscheme gruvbox")
		end,
	},
	{
		"navarasu/onedark.nvim",
		config = function()
			require("onedark").setup({
				style = "deep",
			})
			--require("onedark").load()
		end,
	},
	{
		dir = "~/.local/share/nvim/themes/dracula_pro",
		name = "dracula_pro",
		lazy = false,
		priority = 1000,
		config = function()
			-- vim.cmd("colorscheme dracula_pro")
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			vim.cmd("colorscheme tokyonight")
		end,
	},
}
