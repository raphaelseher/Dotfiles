return {
    {
        "folke/tokyonight.nvim",
        config = function()
            vim.cmd("syntax enable")
            --vim.cmd("colorscheme tokyonight")
        end,
    },
    {
        "https://github.com/Mofiqul/dracula.nvim",
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        lazy = false,
        config = function()
            vim.cmd("syntax enable")
            vim.cmd("colorscheme catppuccin-macchiato")
        end,
    }
}
