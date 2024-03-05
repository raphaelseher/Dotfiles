return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			-- Customize or remove this keymap to your liking
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "Format buffer",
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
			javascript = { { "prettierd", "prettier" } },
			typescript = { { "prettierd", "prettier" } },
			html = { { "prettierd", "prettier" } },
			["*"] = { "codespell" },
			["_"] = { "trim_whitespace" },
		},
		format_on_save = function(bufnr)
			-- Disable with a global or buffer-local variable
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end
			return { timeout_ms = 500, lsp_fallback = true }
		end,
	},
}
