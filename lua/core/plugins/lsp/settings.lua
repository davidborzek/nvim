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
	on_attach = on_attach,
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
