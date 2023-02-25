vim.g.mapleader = " "

vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true })

vim.api.nvim_set_keymap("n", "<leader>ff", ":Telescope find_files<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>fg", ":Telescope live_grep<CR>", {})

vim.api.nvim_set_keymap("n", "<leader>+", ":vertical resize +5<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>-", ":vertical resize -5<CR>", {})

vim.api.nvim_set_keymap("n", "<leader>tn", ":TestNearest<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>tl", ":TestLast<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>tf", ":TestFile<CR>", {})

vim.api.nvim_set_keymap("n", "<leader>git", ":TermExec direction=float cmd=lazygit<CR>", {})
