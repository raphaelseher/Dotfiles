require("nvim-treesitter.configs").setup({
	-- A list of parser names, or "all" (the four listed parsers should always be installed)
	ensure_installed = { "c", "lua", "vim", "cpp", "css", "html", "python", "ruby", "typescript", "javascript" },
})

require("nvim-tree").setup()

require("nvim-test").setup({
	term = "toggleterm",
	termOpts = {
		direction = "float",
	},
})

require("telescope").setup({
	defaults = {
		file_ignore_patterns = {
			"node_modules",
			"vendor",
		},
	},
})
