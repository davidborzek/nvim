local ts = require("core.utils.treesitter")

local expand = vim.fn.expand
local cmd = vim.cmd

local M = {}

M.test_nearest = function()
	local path = expand("%:p")
	local test_name = ts.find_child_node_name_by_type("function_declaration", "identifier")

	if not test_name then
		vim.notify({ "Failed to run test.", "Could not find test function name." }, "error", { title = "Go Test" })
		return
	end

	cmd("!go test -v -run '^" .. test_name .. "$' " .. path)
end

M.test_package = function()
	local path = expand("%:p:h")
	cmd("!go test -v " .. path)
end

M.test_file = function()
	local path = expand("%:p")
	cmd("!go test -v " .. path)
end

M.test = function()
	cmd("!go test -v ./...")
end

return M
