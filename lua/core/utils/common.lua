local M = {}

-- splits a string and returns a table
M.split_string = function(input, sep)
	local t = {}
	for str in string.gmatch(input, sep) do
		table.insert(t, str)
	end
	return t
end

M.split_by_line = function(input)
	return M.split_string(input, "([^\n]*)\n?")
end

-- create or open a file
-- it also creates the directories
M.create_or_open_file = function(dir, filename, opts)
	opts = opts or {}

	local filepath = dir .. "/" .. filename
	if vim.loop.fs_stat(filepath) then
		vim.cmd(":e " .. filepath)
		return
	end

	if not vim.loop.fs_stat(dir) then
		vim.fn.mkdir(dir, "p")
	end

	vim.cmd("enew")
	local buf = vim.api.nvim_get_current_buf()
	vim.api.nvim_buf_set_name(buf, filepath)

	if opts.content then
		vim.api.nvim_buf_set_lines(buf, 0, -1, true, M.split_by_line(opts.content))
	end

	if opts.ft then
		vim.cmd("set filetype=" .. opts.ft)
	end

	vim.cmd("w")
end

return M
