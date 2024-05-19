return {
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"hrsh7th/cmp-buffer",
	},
	{
		"hrsh7th/nvim-cmp",
	},
	{
		"David-Kunz/cmp-npm",
	},
	{
		"L3MON4D3/LuaSnip",
		config = function()
			local luasnip = require("luasnip")
			local cmp = require("cmp")

			cmp.setup({
				sources = {
					{ name = "buffer" },
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "vim-dadbod-completion" },
				},
				mapping = {
					["<cr>"] = cmp.mapping.confirm({ select = true }),
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
			})
		end,
	},
	{
		"saadparwaiz1/cmp_luasnip",
	},
}
