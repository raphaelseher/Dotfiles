return {
	{
		"folke/tokyonight.nvim",
		config = function()
			--vim.cmd("colorscheme tokyonight")
		end,
	},
	{
		"https://github.com/Mofiqul/dracula.nvim",
		priority = 1000,
		lazy = false,
		config = function()
			vim.cmd("syntax enable")
			-- vim.cmd("colorscheme dracula")
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
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
			require("onedark").load()
		end,
	},
}
