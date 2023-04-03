local ts = require("core.utils.treesitter")
local ts_utils = require("nvim-treesitter.ts_utils")

local terminal = require("core.utils.terminal")

local M = {}

local get_method_name = function()
	return ts.find_child_node_name_by_type("method_declaration", "identifier")
end

local get_class_name = function()
	return ts.find_child_node_name_by_type("class_declaration", "identifier")
end

local get_package_name = function()
	local current_node = ts_utils.get_node_at_cursor()
	if not current_node then
		return nil
	end

	local program_node = ts.find_node_by_type(current_node, "program")
	if not program_node then
		return nil
	end

	local package_node = ts.find_child_by_type(program_node, "package_declaration")
	if not program_node then
		return nil
	end

	local identifier = ts.find_child_by_type(package_node, "scoped_identifier")
	if not identifier then
		return nil
	end
	return vim.treesitter.query.get_node_text(identifier, 0)
end

local get_full_class_name = function()
	local package = get_package_name()
	if not package then
		return nil
	end

	local class = get_class_name()
	if not class then
		return nil
	end

	return package .. "." .. class
end

local run_maven_test = function(test)
	local mvn_cmd = vim.fn.findfile("mvnw")
	if mvn_cmd ~= "" then
		mvn_cmd = "./mvnw test"
	else
		mvn_cmd = "mvn test"
	end

	if test then
		mvn_cmd = mvn_cmd .. ' -Dtest="' .. test .. '"'
	end

	terminal.run(mvn_cmd, true)
end

M.maven_test_nearest = function()
	local method_name = get_method_name()
	if not method_name then
		vim.notify({ "Failed to run test.", "Could not find method name." }, "error", { title = "Java Test" })
		return
	end

	local class = get_full_class_name()
	if not class then
		vim.notify({ "Failed to run test.", "Could not find class name." }, "error", { title = "Java Test" })
		return
	end

	local test_name = class .. "\\#" .. method_name

	run_maven_test(test_name)
end

M.maven_test_class = function()
	local class = get_full_class_name()
	if not class then
		vim.notify({ "Failed to run test.", "Could not find class name." }, "error", { title = "Java Test" })
		return
	end

	run_maven_test(class)
end

M.maven_test = function()
	run_maven_test()
end

return M
