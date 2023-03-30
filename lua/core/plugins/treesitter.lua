local settings = require("core.settings")

return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = settings.treesitter_ensure_installed,
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
