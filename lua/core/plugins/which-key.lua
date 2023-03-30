return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		plugins = { spelling = true },
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		local keymaps = {
			mode = { "n", "v" },
			["<leader>g"] = { name = "+git" },
		}
		wk.register(keymaps)
	end,
}
