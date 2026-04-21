return {
	{
		"folke/tokyonight.nvim",
		config = function()
			-- vim.cmd("colorscheme tokyonight")
		end,
	},
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
		"oxfist/night-owl.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- load the colorscheme here
			require("night-owl").setup()
			vim.cmd.colorscheme("night-owl")
		end,
	},
	-- {
	-- 	dir = "~/.local/share/nvim/themes/dracula_pro",
	-- 	name = "dracula_pro",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		-- vim.cmd("colorscheme dracula_pro")
	-- 	end,
	-- }
}
