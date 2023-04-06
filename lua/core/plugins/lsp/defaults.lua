local keys = require("core.keys")
local M = {}

function M.on_attach(client, buffer)
	keys.map_lsp_keys(buffer)
end

return M
