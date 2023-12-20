local util = require("lspconfig/util")

local home = os.getenv("HOME")
local mason_dir = home .. "/.local/share/nvim/mason"

local M = {}

M.gopls = {
	cmd = { "gopls", "serve" },
	filetypes = { "go", "gomod" },
	root_dir = util.root_pattern("go.mod"),
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
		},
	},
	on_attach = function(_, buffer)
		local goutils = require("core.utils.go")

		vim.api.nvim_buf_create_user_command(buffer, "GoTestNearest", function()
			goutils.test_nearest()
		end, { desc = "Test nearest go function" })

		vim.api.nvim_buf_create_user_command(buffer, "GoTestFile", function()
			goutils.test_file()
		end, { desc = "Test go file" })

		vim.api.nvim_buf_create_user_command(buffer, "GoTestPackage", function()
			goutils.test_package()
		end, { desc = "Test go package" })

		vim.api.nvim_buf_create_user_command(buffer, "GoTestAll", function()
			goutils.test()
		end, { desc = "Test go project" })

		require("core.plugins.dap.go")
	end,
}

M.cssmodules_ls = {
	on_attach = function(client, _)
		client.server_capabilities.definitionProvider = false
	end,
}

M.yamlls = {
	settings = {
		yaml = {
			schemas = {
				["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
				["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "/*docker-compose.yml",
			},
		},
	},
}

M.lua_ls = {
	settings = {
		Lua = {
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
		},
	},
}

M.perlnavigator = {
	cmd = { mason_dir .. "/bin/perlnavigator", "--stdio" },
}

return M
