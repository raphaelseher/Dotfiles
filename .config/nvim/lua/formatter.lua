vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    php = { "blade-formatter", "php_cs_fixer" },
    cpp = { "clang-format" },
    go = { "goimports", "gofmt" },
    javascript = { { "prettierd", "prettier" } },
    typescript = { { "prettierd", "prettier" } },
    html = { { "prettierd", "prettier" } },
    ["*"] = { "codespell" },
    ["_"] = { "trim_whitespace" },
  },
})
