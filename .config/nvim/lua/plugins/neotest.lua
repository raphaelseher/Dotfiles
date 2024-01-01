return {
	"nvim-neotest/neotest",
	dependencies = {
		"vim-test/vim-test",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"olimorris/neotest-phpunit",
		"nvim-neotest/neotest-vim-test",
		"nvim-neotest/neotest-plenary",
	},
	event = { "LspAttach" },
	keys = {
		{
			"<leader>tn",
			[[<cmd>lua require("neotest").run.run()<CR>]],
			desc = "NeoTree",
		},
		{
			"<leader>tf",
			[[<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<CR>]],
			desc = "NeoTree",
		},
		{
			"<leader>td",
			[[<cmd>lua require("neotest").run.run({strategy = "dap"})<CR>]],
			desc = "NeoTree",
		},
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-phpunit")({
					phpunit_cmd = function()
						return "vendor/bin/phpunit"
					end,
					env = {
						XDEBUG_CONFIG = "idekey=neotest",
					},
					dap = require("dap").configurations.php[1],
				}),
				require("neotest-plenary"),
				require("neotest-vim-test")({
					ignore_file_types = { "vim", "lua" },
				}),
			},
		})
	end,
}
