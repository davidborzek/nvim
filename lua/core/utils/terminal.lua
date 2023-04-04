local M = {}

M.run = function(cmd, opts)
	opts = opts or {}
	opts.win_cmd = opts.win_cmd or "belowright split"

	vim.cmd(opts.win_cmd .. " | terminal " .. cmd)

	if opts.scroll_bottom then
		vim.cmd("norm G")
	end
end

return M
