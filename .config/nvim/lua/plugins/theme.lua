return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd("syntax enable")
            --vim.cmd("colorscheme tokyonight")
        end,
    },
    {
        "https://github.com/Mofiqul/dracula.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd("syntax enable")
            vim.cmd("colorscheme dracula")
        end,
    }
}
