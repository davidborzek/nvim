local ts = require("core.utils.treesitter")
local common = require("core.utils.common")
local ts_utils = require("nvim-treesitter.ts_utils")

local terminal = require("core.utils.terminal")

local M = {}

local junit_test_class_template = [[
package %s;

import org.junit.jupiter.api.Test;

class %s {
	@Test
	void test() {
	}

}
]]

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

local get_maven_cmd = function()
	if vim.fn.findfile("mvnw") ~= "" then
		return "./mvnw"
	else
		if vim.fn.executable("mvn") == 0 then
			vim.notify({ "Maven not found in path." }, "error", { title = "Maven" })
			return
		end

		return "mvn"
	end
end

local run_maven_test = function(test)
	local mvn_cmd = get_maven_cmd() .. " test"

	if test then
		mvn_cmd = mvn_cmd .. ' -Dtest="' .. test .. '"'
	end

	terminal.run(mvn_cmd, { scroll_bottom = true })
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

M.maven_sync = function()
	vim.cmd("!" .. get_maven_cmd() .. " dependency:resolve")
end

-- creates or opens a junit test class for the class in the current opened buffer
M.create_junit_test = function()
	local package = get_package_name()
	if not package then
		vim.notify({ "Failed create test.", "Could not get package name." }, "error", { title = "Java Test" })
		return
	end

	local class = get_class_name()
	if not class then
		vim.notify({ "Failed to create test.", "Could not get class name." }, "error", { title = "Java Test" })
		return
	end

	local test_dir = string.gsub(vim.fn.expand("%:p:h"), "/main/", "/test/")
	if test_dir == "" then
		vim.notify({ "Failed to create test.", "Could not get directory path." }, "error", { title = "Java Test" })
		return
	end

	local test_class_name = class .. "Test"
	local test_class_path = test_class_name .. ".java"

	common.create_or_open_file(test_dir, test_class_path, {
		ft = "java",
		content = string.format(junit_test_class_template, package, test_class_name),
	})
end

return M
