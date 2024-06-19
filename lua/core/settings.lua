local M = {}

-- treesitter parsers to be installed
M.treesitter_ensure_installed = {
	"bash",
	"c",
	"css",
	"dockerfile",
	"fish",
	"go",
	"gomod",
	"gosum",
	"hcl",
	"html",
	"java",
	"javascript",
	"json",
	"latex",
	"lua",
	"markdown",
	"markdown_inline",
	"perl",
	"python",
	"regex",
	"rust",
	"scss",
	"sql",
	"terraform",
	"toml",
	"tsx",
	"typescript",
	"vim",
	"vimdoc",
	"yaml",
}

-- LSP servers that should be installed by mason-lspconfig
M.lsp_servers = {
	"ansiblels",
	"bashls",
	"cssls",
	"cssmodules_ls",
	"gopls",
	"jdtls",
	"jsonls",
	"lua_ls",
	"perlnavigator",
	"pyright",
	"rust_analyzer",
	"texlab",
	"tsserver",
	"yamlls",
}

-- Formatters that should be installed by mason
M.formatters = {
	"prettier",
	"shfmt",
	"stylua",
	"goimports",
	"google-java-format",
}

-- Linters that should be installed by mason
M.linters = {
	"staticcheck",
}

-- Debug tools that should be installed by mason
M.dap_tools = {
	"delve",
	"java-debug-adapter",
	"java-test",
}

-- path to sdkman
M.sdkman_path = os.getenv("SDKMAN_DIR")

return M
