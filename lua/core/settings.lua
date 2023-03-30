local M = {}

-- LSP servers that should be installed by mason-lspconfig
M.lsp_servers = {
	"ansiblels",
	"bashls",
	"gopls",
	"jdtls",
	"jsonls",
	"lua_ls",
	"rust_analyzer",
	"tsserver",
	"yamlls",
}

-- Formatters that should be installed by mason
M.formatters = {
	"prettier",
	"shfmt",
	"stylua",
}

-- Linters that should be installed by mason
M.linters = {}

-- Debug tools that should be installed by mason
M.dap_tools = {
	"delve",
	"java-debug-adapter",
	"java-test",
}

return M
