local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("settings")
require("mappings")

require("lazy").setup("plugins", {})

require("commands")
--
-- require("plugins")
--
-- require("uiconfiguration")
--
--
-- require("lsp")
--
-- require("linter")
--
-- require("formatter")
--
-- require("theme")
--
-- require("debugger")
--
require("local_rc").load()
