return {
	{
		"folke/tokyonight.nvim",
		config = function()
			vim.cmd("syntax enable")
			--vim.cmd("colorscheme tokyonight")
		end,
	},
	{
		"https://github.com/Mofiqul/dracula.nvim",
		priority = 1000,
		lazy = false,
		config = function()
			vim.cmd("syntax enable")
			vim.cmd("colorscheme dracula")
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
	},
}
