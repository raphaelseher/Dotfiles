-- Autoformatting

vim.api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
		-- FormatDisable! will disable formatting just for this buffer
		vim.b.disable_autoformat = true
	else
		vim.g.disable_autoformat = true
	end
end, {
	desc = "Disable autoformat-on-save",
	bang = true,
})

vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b.disable_autoformat = false
	vim.g.disable_autoformat = false
end, {
	desc = "Re-enable autoformat-on-save",
})

vim.api.nvim_create_user_command("FormatStatus", function()
	local bufferAutoformat = vim.b.disable_autoformat
	local globalAutoformat = vim.g.disable_autoformat

	print(
		string.format(
			"Buffer autoformat disabled: %s\nGlobal autoformat disabled: %s",
			bufferAutoformat,
			globalAutoformat
		)
	)
end, {
	desc = "Print status of autoformat-on-save",
})

-- Highlight yanked text for 200ms using the "Visual" highlight group
vim.api.nvim_create_augroup("highlight_yank", {})
vim.api.nvim_create_autocmd("TextYankPost", {
	group = "highlight_yank",
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})
