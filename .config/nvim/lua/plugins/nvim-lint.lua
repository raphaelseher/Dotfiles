return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lint = require("lint")

		lint.linters_by_ft = {
			lua = { "luacheck" },
			markdown = { "vale" },
			cpp = { "cppcheck", "clazy" },
			php = { "phpcs" },
			html = { "eslint" },
			javascript = { "eslint" },
			typescript = { "eslint" },
		}

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            callback = function()
                lint.try_lint()
            end,
        })
    end,
    opts = {},
}
