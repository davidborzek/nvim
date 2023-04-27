local settings = require("core.settings")

-- helper function to install packages via mason
local mason_install = function(packages)
	local registry = require("mason-registry")
	registry.refresh()
	for _, pkg_name in ipairs(packages) do
		local p = registry.get_package(pkg_name)
		if not p:is_installed() then
			p:install()
		end
	end
end

return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		require("mason").setup()

		-- ensure formatters are installed
		mason_install(settings.formatters)
		-- ensure linters are installed
		mason_install(settings.linters)
		-- ensure dap tools are installed
		mason_install(settings.dap_tools)

		-- install LSPs
		require("mason-lspconfig").setup({ ensure_installed = settings.lsp_servers })
	end,
}
