vim.cmd("syntax enable")

vim.cmd("colorscheme dracula")
--vim.cmd("colorscheme gruvbox")
--vim.cmd("let g:gruvbox_contrast_dark = 'hard'")
vim.cmd("set background=dark")

-- require("onedark").setup({
-- 	style = "darker",
-- })
-- require("onedark").load()

require("lualine").setup()

