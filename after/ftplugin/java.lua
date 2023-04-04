local home = os.getenv("HOME")
local jdtls = require("jdtls")
local jdtls_setup = require("jdtls.setup")

local java_utils = require("core.utils.java")

local create_user_command = vim.api.nvim_buf_create_user_command

local root_markers = { "gradlew", "mvnw", ".git" }
local root_dir = jdtls_setup.find_root(root_markers)

local mason_dir = home .. "/.local/share/nvim/mason"
local debug_plugin_jar = mason_dir
	.. "/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"

local vscode_java_test_jars = mason_dir .. "/packages/java-test/extension/server/*.jar"

local lombok_jar = mason_dir .. "/packages/jdtls/lombok.jar"

local bundles = {
	vim.fn.glob(debug_plugin_jar, 1),
}

local function parse_java_test_result(items)
	local count = 0
	for _ in pairs(items) do
		count = count + 1
	end

	if count > 0 then
		vim.notify({ count .. " test(s) failed!", "See dap-repl for results." }, "error", { title = "Java Test" })
	else
		vim.notify({ "Pass!", "See dap-repl for results." }, "info", { title = "Java Test" })
	end
end

local function add_commands(buffer)
	create_user_command(buffer, "JavaTestClass", function()
		require("jdtls").test_class({
			after_test = parse_java_test_result,
		})
	end, { desc = "Test java class." })

	create_user_command(buffer, "JavaTestNearest", function()
		require("jdtls").test_nearest_method({
			after_test = parse_java_test_result,
		})
	end, { desc = "Test nearest java test." })

	create_user_command(buffer, "JavaCreateTest", function()
		java_utils.create_junit_test()
	end, { desc = "Test nearest java test." })

	create_user_command(buffer, "MavenTest", function()
		java_utils.maven_test()
	end, { desc = "Test java project using maven." })

	create_user_command(buffer, "MavenTestClass", function()
		java_utils.maven_test_class()
	end, { desc = "Test java class using maven." })

	create_user_command(buffer, "MavenTestNearest", function()
		java_utils.maven_test_nearest()
	end, { desc = "Test nearest java test using maven." })

	create_user_command(buffer, "MavenSync", function()
		java_utils.maven_sync()
	end, { desc = "Sync maven dependencies." })
end

-- add vscode-java-test jars to bundles list
vim.list_extend(bundles, vim.split(vim.fn.glob(vscode_java_test_jars, 1), "\n"))

jdtls.start_or_attach({
	cmd = { "jdtls", string.format("--jvm-arg=-javaagent:%s", lombok_jar) },
	root_dir = root_dir,
	init_options = {
		bundles = bundles,
	},
	on_attach = function(client, buffer)
		require("core.plugins.lsp.defaults").on_attach(client, buffer)
		require("core.plugins.dap.java")

		add_commands(buffer)

		jdtls.setup_dap({ hotcodereplace = "auto" })
		jdtls_setup.add_commands()

		-- load .vscode/launch.json
		require("dap.ext.vscode").load_launchjs()

		local function buf_set_keymap(...)
			vim.api.nvim_buf_set_keymap(buffer, ...)
		end

		buf_set_keymap(
			"n",
			"<leader>i",
			"<Cmd>lua require'jdtls'.organize_imports()<CR>",
			{ desc = "Organize imports (Java)", silent = true }
		)
		buf_set_keymap(
			"v",
			"<leader>em",
			"<Esc><Cmd>lua require'jdtls'.extract_method(true)<CR>",
			{ desc = "Extract method (Java)", silent = true }
		)
		buf_set_keymap(
			"n",
			"<leader>u",
			"<Cmd>lua require'jdtls'.update_project_config()<CR>",
			{ desc = "Update project config (Java)", silent = true }
		)
	end,
})
