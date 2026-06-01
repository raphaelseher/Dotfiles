local uv = vim.uv

local function load()
	local local_rc_name = ".nvimrc.lua"
	local stat = uv.fs_stat(local_rc_name)

	if not stat then
		return
	end

	if stat.uid == uv.getuid() then
		dofile(local_rc_name)
	else
		print(local_rc_name .. " exists but is not loaded. Security reason: a different owner.")
	end
end

return {
	load = load,
}
