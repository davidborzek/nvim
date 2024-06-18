return {
	"phaazon/hop.nvim",
	branch = "v2",
	config = function()
		require("hop").setup()
	end,
	keys = {
		{
			"<leader>h",
			"<cmd>HopWord<CR>",
			desc = "Toggle word hop",
			silent = true,
		},
		{
			"<leader>H",
			"<cmd>HopPattern<CR>",
			desc = "Toggle pattern hop",
			silent = true,
		},
	},
}
