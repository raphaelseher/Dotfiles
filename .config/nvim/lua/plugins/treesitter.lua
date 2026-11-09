-- nvim-treesitter was fully rewritten (see its README): the old
-- `nvim-treesitter.configs.setup { ensure_installed, highlight, indent }`
-- API is gone. The plugin is now a parser installer + query provider and it
-- no longer enables highlighting/indentation for you. On Neovim 0.12 only
-- lua/markdown/vimdoc/query get treesitter highlighting from bundled runtime
-- ftplugins; for everything else you must start it per buffer. Same for
-- indentation. So we enable both per buffer here.

local LANGUAGES = {
	"c",
	"lua",
	"vim",
	"vimdoc",
	"cpp",
	"css",
	"html",
	"typescript",
	"javascript",
	"go",
	"php",
	"sql",
}

local function ts_on_filetype(ev)
	-- Skip huge buffers (replaces the old `disable` option).
	if vim.api.nvim_buf_line_count(ev.buf) > 10000 then
		return
	end

	-- Highlighting: Neovim 0.12 does not auto-start treesitter for most
	-- filetypes, so start it per buffer. pcall guards against filetypes with
	-- no parser installed yet (skips them until restarted).
	local ok = pcall(vim.treesitter.start, ev.buf)
	if ok then
		-- Indentation: still provided by nvim-treesitter (experimental).
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end
end

return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false, -- this plugin does not support lazy-loading
		build = ":TSUpdate",
		config = function()
			local ts = require("nvim-treesitter")

			-- Setup (only install_dir is configurable; defaults are fine).
			ts.setup({})

			-- Install parsers (no-op for already-installed ones; async).
			-- A restart after installing is enough; no need to re-enable
			-- anything on buffers that are already open.
			ts.install(LANGUAGES)

			-- Enable treesitter highlighting + indentation whenever one of these
			-- filetypes opens.
			vim.api.nvim_create_autocmd("FileType", {
				pattern = LANGUAGES,
				callback = ts_on_filetype,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			enable = true,
			max_lines = 1,
			multiline_threshold = 2,
		},
	},
}
