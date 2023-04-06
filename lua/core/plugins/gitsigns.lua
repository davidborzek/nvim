local keys = require("core.keys")

local on_attach = function(buffer)
	keys.map_gitsigns_keys(buffer)
end

return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			current_line_blame = true,
			current_line_blame_opts = {
				delay = 200,
			},
			on_attach = on_attach,
		})
	end,
}
