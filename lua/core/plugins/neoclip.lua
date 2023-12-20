return {
	"AckslD/nvim-neoclip.lua",
	lazy = false,
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	keys = {
		{
			"<leader>y",
			"<cmd>Telescope neoclip<CR>",
			desc = "Yank history",
			silent = true,
		},
	},
	init = function()
		require("neoclip").setup()
		require("telescope").load_extension("neoclip")
	end,
}
