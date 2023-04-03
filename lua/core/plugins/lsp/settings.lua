local lspconfig = require("lspconfig")
local util = require("lspconfig/util")

local on_attach = require("core.plugins.lsp.defaults").on_attach

lspconfig.bashls.setup({
	on_attach = on_attach,
})

lspconfig.gopls.setup({
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
	on_attach = function(client, buffer)
		on_attach(client, buffer)

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
})

lspconfig.tsserver.setup({
	on_attach = on_attach,
})

lspconfig.yamlls.setup({
	settings = {
		yaml = {
			schemas = {
				["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
				["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "/*docker-compose.yml",
			},
		},
	},
	on_attach = on_attach,
})

lspconfig.lua_ls.setup({
	on_attach = on_attach,
})

lspconfig.jsonls.setup({
	on_attach = on_attach,
})

lspconfig.rust_analyzer.setup({
	on_attach = on_attach,
})

lspconfig.ansiblels.setup({
	on_attach = on_attach,
})
