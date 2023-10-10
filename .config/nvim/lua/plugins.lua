return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	use("tpope/vim-surround")
	use("stevearc/dressing.nvim")

	use("morhetz/gruvbox")
	-- use("dracula/vim")
	use("maxmx03/dracula.nvim")
	use("navarasu/onedark.nvim")
	use("christianchiarulli/nvcode-color-schemes.vim")

	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("nvim-lua/plenary.nvim")
	use({ "nvim-telescope/telescope.nvim", tag = "0.1.0" })

	use("nvim-tree/nvim-tree.lua")
	use("nvim-tree/nvim-web-devicons")

	use("neovim/nvim-lspconfig")
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"jay-babu/mason-nvim-dap.nvim",
	})
	use("jose-elias-alvarez/null-ls.nvim")

	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/nvim-cmp")
	use("David-Kunz/cmp-npm")
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")
	use("voldikss/vim-floaterm")
	use("klen/nvim-test")
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
	})
	use({
		"folke/trouble.nvim",
	})

	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("toggleterm").setup()
		end,
	})

	use("mfussenegger/nvim-dap")
	use("rcarriga/nvim-dap-ui")
	use("mxsdev/nvim-dap-vscode-js")
	use({
		"microsoft/vscode-js-debug",
		opt = true,
		run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
	})
	use("leoluz/nvim-dap-go")
end)
