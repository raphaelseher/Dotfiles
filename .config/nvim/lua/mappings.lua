vim.g.mapleader = " "

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true })

vim.api.nvim_set_keymap("n", "<c-p>", ":Telescope find_files<CR>", {})
vim.api.nvim_set_keymap("n", "<c-q>", ":Telescope live_grep<CR>", {})

vim.api.nvim_set_keymap("n", "<leader>+", ":vertical resize +5<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>-", ":vertical resize -5<CR>", {})


require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the four listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "cpp", "css", "html", "python", "ruby", "typescript", "javascript" },
}
