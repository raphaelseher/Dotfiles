-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o> vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
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
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<leader>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)

	vim.api.nvim_set_keymap("n", "<leader>h", "lua ClangdSwitchSourceHeaderForCpp()<CR>", {})

	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
				vim.lsp.buf.format({
					bufnr = bufnr,
					filter = function(fmtclient)
						return fmtclient.name == "null-ls"
					end,
				})
			end,
		})
	end
end

function ClangdSwitchSourceHeaderForCpp()
	vim.api.nvim_command(":ClangdSwitchSourceHeader")
end

vim.api.nvim_command(
	"autocmd FileType c,cpp,h,hpp nnoremap <buffer> <leader>h :lua ClangdSwitchSourceHeaderForCpp()<CR>"
)

require("mason").setup()
require("mason-nvim-dap").setup({
	automatic_setup = true,
	ensure_installed = { "python", "codelldb", "node2" },
})
-- require("mason-nvim-dap").setup_handlers({})
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"dockerls",
		"html",
		"intelephense",
		"jsonls",
		"pyright",
		"tsserver",
		"clangd",
		"gopls",
	},
})

-- :h mason-lspconfig-automatic-server-setup
require("mason-lspconfig").setup_handlers({
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function(server_name) -- default handler (optional)
		require("lspconfig")[server_name].setup({})
	end,
	-- Next, you can provide a dedicated handler for specific servers.
	-- For example, a handler override for the `rust_analyzer`:
	-- ["rust_analyzer"] = function ()
	--    require("rust-tools").setup {}
	-- end
})

-- Completion
local luasnip = require("luasnip")
local cmp = require("cmp")

cmp.setup({
	sources = {
		{ name = "buffer" },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	},
	mapping = {
		["<cr>"] = cmp.mapping.confirm({ select = true }),
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
})
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.clang_format,
		null_ls.builtins.formatting.gofmt,
		null_ls.builtins.formatting.phpcsfixer,
		null_ls.builtins.formatting.phpcbf.with({
			extra_args = function()
				return { "--standard=" .. vim.fn.getcwd() .. "/ruleset.xml" }
			end,
		}),

		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.diagnostics.cpplint,
		null_ls.builtins.diagnostics.cppcheck,
		null_ls.builtins.diagnostics.clazy,
		null_ls.builtins.diagnostics.pylint,
		null_ls.builtins.diagnostics.phpcs.with({
			extra_args = function()
				return { "--standard=" .. vim.fn.getcwd() .. "/ruleset.xml" }
			end,
		}),
		null_ls.builtins.diagnostics.phpmd.with({
			extra_args = function()
				return { "cleancode,codesize,controversial,design,naming,unusedcode" }
			end,
		}),
		null_ls.builtins.diagnostics.markdownlint,

		null_ls.builtins.completion.spell,
	},
	on_attach = on_attach,
})
