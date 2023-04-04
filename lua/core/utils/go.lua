local ts = require("core.utils.treesitter")
local terminal = require("core.utils.terminal")

local M = {}

local run_test = function(opts)
	opts = opts or {}
	local dap = require("dap")

	local args = {}

	if opts.test_name then
		table.insert(args, "-test.run")

		local test_name = opts.test_name
		if opts.exact_match then
			test_name = "^" .. opts.test_name .. "$"
		end

		table.insert(args, test_name)
	end

	if opts.verbose then
		table.insert(args, "-test.v")
	end

	dap.run({
		type = "go",
		name = opts.test_name or "Test",
		request = "launch",
		mode = "test",
		program = opts.path or "${file}",
		args = args,
	})
end

M.test_nearest = function()
	local test_name = ts.find_child_node_name_by_type("function_declaration", "identifier")

	if not test_name then
		vim.notify({ "Failed to run test.", "Could not find test function name." }, "error", { title = "Go Test" })
		return
	end

	run_test({
		test_name = test_name,
		verbose = true,
		exact_match = true,
	})
end

M.test_package = function()
	run_test({
		verbose = true,
		exact_match = true,
		path = "./${relativeFileDirname}",
	})
end

M.test_file = function()
	run_test({
		verbose = true,
	})
end

M.test = function()
	terminal.run("go test -v ./...", { scroll_bottom = true })
end

return M
