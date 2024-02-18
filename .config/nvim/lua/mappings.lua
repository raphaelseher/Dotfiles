vim.g.mapleader = " "

vim.keymap.set("n", "<leader>w", ":w<CR>")

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
vim.api.nvim_set_keymap("n", "<leader>fl", ":Telescope resume<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>fg", ":Telescope live_grep<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>fh", ":Telescope help_tags<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>fd", ":Telescope diagnostics<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>fs", ":Telescope lsp_document_symbols<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>foc", ":Telescope lsp_incoming_calls<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>fic", ":Telescope lsp_outgoing_calls<CR>", {})

vim.api.nvim_set_keymap("n", "<leader>gi", ":Telescope lsp_implementations<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>gr", ":Telescope lsp_references<CR>", {})

vim.api.nvim_set_keymap("n", "<leader>co", ":copen <CR>", {})
vim.api.nvim_set_keymap("n", "<leader>cc", ":cclose <CR>", {})

vim.api.nvim_set_keymap("n", "<leader>+", ":vertical resize +5<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>-", ":vertical resize -5<CR>", {})

vim.api.nvim_set_keymap("n", "<leader>tn", [[:lua require("neotest").run.run()<CR>]], {})
vim.api.nvim_set_keymap("n", "<leader>tf", [[:lua require("neotest").run.run(vim.fn.expand("%"))<CR>]], {})
vim.api.nvim_set_keymap("n", "<leader>td", [[:lua require("neotest").run.run({strategy = "dap"})<CR>]], {})

vim.api.nvim_set_keymap("n", "<leader>dc", ":lua require'dap'.continue()<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>do", ":lua require'dap'.step_over()<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>di", ":lua require'dap'.step_into()<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>du", ":lua require'dapui'.toggle()<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>dn", [[:lua require"osv".launch({port = 8086})<CR>]], {})
vim.api.nvim_set_keymap("n", "<leader>dnn", [[:lua require"osv".run_this()<CR>]], {})

vim.api.nvim_set_keymap("n", "<leader>ee", [[:NvimTreeToggle<CR>]], {})
vim.api.nvim_set_keymap("n", "<leader>ef", [[:NvimTreeFindFile<CR>]], {})

vim.api.nvim_set_keymap("n", "<C-n>", "<cmd>ToggleTerm<cr>", {})

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_attach_auto_diag", { clear = true }),
	callback = function(args)
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local bufopts = { noremap = true, silent = true, buffer = args.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
		-- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
		-- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
		-- vim.keymap.set('n', '<leader>wl', function()
		-- print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		-- end, bufopts)
		-- vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
		vim.keymap.set("v", "<leader>ca", vim.lsp.buf.code_action, bufopts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
		vim.keymap.set("n", "<leader>f", function()
			vim.lsp.buf.format({ async = true })
		end, bufopts)

		vim.api.nvim_set_keymap("n", "<leader>h", "lua ClangdSwitchSourceHeaderForCpp()<CR>", {})
	end,
})

function ClangdSwitchSourceHeaderForCpp()
	vim.api.nvim_command(":ClangdSwitchSourceHeader")
end

vim.api.nvim_command(
	"autocmd FileType c,cpp,h,hpp nnoremap <buffer> <leader>h :lua ClangdSwitchSourceHeaderForCpp()<CR>"
)

vim.api.nvim_set_keymap(
	"n",
	"<leader>al",
	[[:cexpr system("./docker/bin/tools.sh test psalm-diff origin/staging | grep -v 'No problems found*' |  grep -vE '^[0-9]+/[0-9]+: Checking file' | grep -v 'Checking *'")
<CR>]],
	{}
)
vim.api.nvim_set_keymap("n", "<leader>as", ":Telescope resume<CR>", {})
