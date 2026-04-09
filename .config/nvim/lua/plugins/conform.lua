return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			-- Customize or remove this keymap to your liking
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "Format buffer",
		},
		{
			-- Format selected lines in visual mode
			"<leader>f",
			function()
				local start_pos = vim.fn.getpos("'<")
				local end_pos = vim.fn.getpos("'>")
				require("conform").format({
					async = true,
					lsp_format = "fallback",
					range = {
						start = { start_pos[2], start_pos[3] - 1 },
						["end"] = { end_pos[2], end_pos[3] - 1 },
					},
				})
			end,
			mode = "v",
			desc = "Format selected lines",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			php = function(bufnr)
				local filename = vim.api.nvim_buf_get_name(bufnr)
				local end_str = string.sub(filename, -9)
				if end_str == "blade.php" then
					return { "blade-formatter" }
				end

				return { "php_cs_fixer" }
			end,
			cpp = { "clang-format" },
			go = { "goimports", "gofmt" },
			javascript = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
			html = { "prettierd", "prettier", stop_after_first = true },
			["*"] = { "codespell" },
			["_"] = { "trim_whitespace" },
		},
		format_on_save = function(bufnr)
			-- Disable with a global or buffer-local variable
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end
			return { timeout_ms = 500, lsp_format = "fallback" }
		end,
	},
}
