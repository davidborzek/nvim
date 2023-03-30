return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({
			renderer = {
				group_empty = true,
				indent_width = 1,
			},
			update_focused_file = {
				enable = true,
			},
			git = {
				ignore = false,
			},
			diagnostics = {
				enable = true,
			},
		})
	end,
}
