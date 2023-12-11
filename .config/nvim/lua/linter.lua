vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        require("lint").try_lint()
    end,
})

require('lint').linters_by_ft = {
    lua = { 'luacheck' },
    markdown = { 'vale' },
    cpp = { 'cppcheck', 'clazy', 'clangtidy', },
    php = { 'phpcs', 'psalm' },
    html = { 'eslint' },
    javascript = { 'eslint' },
    typescript = { 'eslint' },
}
