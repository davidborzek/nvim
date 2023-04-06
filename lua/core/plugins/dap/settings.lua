local dap = require("dap")
local keys = require("core.keys")

local M = {}

M.setup = function(opts)
	opts = opts or {}

	vim.api.nvim_set_hl(0, "DapBreakbointColor", { fg = "#ff0000" })
	vim.fn.sign_define("DapBreakpoint", { text = "⬤", texthl = "DapBreakbointColor", linehl = "", numhl = "" })

	dap.listeners.after.event_initialized["dap_config"] = function()
		if opts.open_repl then
			dap.repl.open()
		end
	end

	keys.map_dap_keys()
end

return M
