return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		lazy = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				defaults = {
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--fixed-strings",
					},
					file_ignore_patterns = {
						"node_modules",
						"vendor",
						".git",
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
							prompt_position = "top",
							preview_height = 0.7,
							mirror = true,
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
