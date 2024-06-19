local utils = require("core.utils.common")

local M = {}

M.compile = function(file, out, notify)
	vim.fn.mkdir(out, "p")

	local output = vim.fn.system("pdflatex -output-directory=" .. out .. " " .. file)
	output = output:gsub("\n[^\n]*$", "")

	if vim.v.shell_error ~= 0 then
		vim.notify(utils.split_by_line(output), "error", { title = "TeX Compile" })
		return
	end

	if notify then
		vim.notify("Successfully compiled!", "info", { title = "TeX Compile" })
	end
end

return M
