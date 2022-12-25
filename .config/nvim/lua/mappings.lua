vim.g.mapleader = " "

vim.api.nvim_set_keymap("n", "<leader>y", "+y", { noremap = true })
vim.api.nvim_set_keymap("v", "<leader>y", "+y", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>Y", "+Y", {})

vim.api.nvim_set_keymap("n", "<leader>d", "_d", { noremap = true })
vim.api.nvim_set_keymap("v", "<leader>d", "_d", { noremap = true })

vim.o.splitright = true
vim.o.splitbelow = true

vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true })

function OpenTerminal()
  vim.api.nvim_command("split term://zsh")
end

vim.api.nvim_set_keymap("n", "<c-n>", ":call OpenTerminal()<CR>", {})

vim.api.nvim_set_keymap("n", "<c-p>", ":Telescope find_files<CR>", {})
vim.api.nvim_set_keymap("n", "<c-q>", ":Telescope live_grep<CR>", {})

vim.api.nvim_set_keymap("n", "<leader>+", ":vertical resize +5<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>-", ":vertical resize -5<CR>", {})
