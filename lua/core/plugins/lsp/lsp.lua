local lspconfig = require("lspconfig")
local keys = require("core.keys")

local lsp_servers = require("core.settings").lsp_servers
local lsp_config = require("core.plugins.lsp.config")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local function on_attach(_, buffer)
	keys.map_lsp_keys(buffer)
end

for _, lsp in pairs(lsp_servers) do
	-- The Java lsp is handled by nvim-jdtls in after/ftplugin/java.lua
	if lsp == "jdtls" then
		goto continue
	end

	-- Find custom lsp config
	local config = lsp_config[lsp] or {}
	local custom_on_attach = config.on_attach
	if custom_on_attach ~= nil then
		config.on_attach = function(client, buffer)
			on_attach(client, buffer)
			custom_on_attach(client, buffer)
		end
	else
		config.on_attach = on_attach
	end

	config.capabilities = capabilities

	lspconfig[lsp].setup(config)

	::continue::
end
