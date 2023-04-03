local M = {}

M.run = function(cmd, scroll_bottom)
	vim.cmd("terminal " .. cmd)

	if scroll_bottom then
		vim.cmd("norm G")
	end
end

return M
