vim.g.mapleader = " "

vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true })

vim.api.nvim_set_keymap("n", "<leader>ff", ":Telescope find_files<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>fg", ":Telescope live_grep<CR>", {})

vim.api.nvim_set_keymap("n", "<leader>+", ":vertical resize +5<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>-", ":vertical resize -5<CR>", {})

vim.api.nvim_set_keymap("n", "<leader>tn", ":TestNearest<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>tl", ":TestLast<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>tf", ":TestFile<CR>", {})

vim.api.nvim_set_keymap("n", "<leader>dc", ":lua require'dap'.continue()<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>do", ":lua require'dap'.step_over()<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>di", ":lua require'dap'.step_into()<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>du", ":lua require'dapui'.toggle()<CR>", {})

vim.api.nvim_set_keymap("n", "<leader>tt", "<cmd>TroubleToggle<cr>", {})
