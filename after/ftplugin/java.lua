local home = os.getenv("HOME")
local jdtls = require("jdtls")
local jdtls_setup = require("jdtls.setup")

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

-- add vscode-java-test jars to bundles list
vim.list_extend(bundles, vim.split(vim.fn.glob(vscode_java_test_jars, 1), "\n"))

jdtls.start_or_attach({
	cmd = { "jdtls", string.format("--jvm-arg=-javaagent:%s", lombok_jar) },
	root_dir = root_dir,
	init_options = {
		bundles = bundles,
	},
	on_attach = function(client, bufnr)
		require("core.plugins.lsp.defaults").on_attach(client, buffer)

		jdtls.setup_dap({ hotcodereplace = "auto" })
		jdtls_setup.add_commands()

		-- load .vscode/launch.json
		require("dap.ext.vscode").load_launchjs()

		local function buf_set_keymap(...)
			vim.api.nvim_buf_set_keymap(bufnr, ...)
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