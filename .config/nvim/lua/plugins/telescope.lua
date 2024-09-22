return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		lazy = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				defaults = {
					file_ignore_patterns = {
						"node_modules",
						"vendor",
					},
					preview = {
						filesize_limit = 0.5, -- MB
					},
					layout_strategy = "flex",
					layout_config = {
						flex = {
							flip_columns = 220,
						},
						vertical = {
							prompt_position = "top", -- Keeps the search prompt at the top
							preview_height = 0.7, -- Adjust the height of the preview window (40% of total height)
							mirror = true, -- Puts the preview below the results
						},
					},
				},
				pickers = {
					find_files = {
						hidden = true,
					},
				},
			})
		end,
	},
}
