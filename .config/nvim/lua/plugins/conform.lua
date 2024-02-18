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
            php = { "php_cs_fixer", "blade-formatter" },
            cpp = { "clang-format" },
            go = { "goimports", "gofmt" },
            javascript = { { "prettierd", "prettier" } },
            typescript = { { "prettierd", "prettier" } },
            html = { { "prettierd", "prettier" } },
            ["*"] = { "codespell" },
            ["_"] = { "trim_whitespace" },
        },
        format_on_save = { timeout_ms = 500, lsp_fallback = true },
    }
}
