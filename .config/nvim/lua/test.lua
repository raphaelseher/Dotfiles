require("nvim-test").setup({
    term = "toggleterm",
    termOpts = {
        direction = "float",
    },
    runners = {
        php = "nvim-test.runners.phpunit",
    }
})

require('nvim-test.runners.phpunit'):setup {
    command = "phpunit",
    -- file_pattern = "\\v(__tests__/.*|(spec|test))\\.(js|jsx|coffee|ts|tsx)$",
    -- find_files = { "{name}.test.{ext}", "{name}.spec.{ext}" },
}
