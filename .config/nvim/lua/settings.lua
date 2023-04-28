local options = {
	tabstop = 4,
	softtabstop = 4,
	shiftwidth = 4,
	expandtab = true,
	smartindent = true,
	exrc = true,
	nu = true,
	relativenumber = true,
	nohlsearch = true,
	hidden = true,
	ignorecase = true,
	noerrorbells = true,
	nowrap = true,
	noswapfile = true,
	nobackup = true,
	undodir = vim.fn.stdpath("config") .. "/undodir",
	undofile = true,
	incsearch = true,
	termguicolors = true,
	colorcolumn = 100,
	signcolumn = "yes",
	secure = true,
}

for key, value in pairs(options) do
	vim.o[key] = value
end

vim.o.splitright = true
vim.o.splitbelow = true
