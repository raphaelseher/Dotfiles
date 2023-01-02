vim.g.mapleader = " "

vim.api.nvim_set_keymap("n", "<leader>y", "+y", {})
vim.api.nvim_set_keymap("v", "<leader>y", "+y", {})

vim.api.nvim_set_keymap("n", "<leader>d", "_d", { noremap = true })
vim.api.nvim_set_keymap("v", "<leader>d", "_d", { noremap = true })

vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true })

vim.api.nvim_set_keymap("n", "<c-p>", ":Telescope find_files<CR>", {})
vim.api.nvim_set_keymap("n", "<c-q>", ":Telescope live_grep<CR>", {})

vim.api.nvim_set_keymap("n", "<leader>+", ":vertical resize +5<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>-", ":vertical resize -5<CR>", {})
