return {
	"akinsho/bufferline.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		options = {
			close_command = "Bdelete %d",
			right_mouse_command = "Bdelete %d",
			diagnostics = "nvim_lsp",
			offsets = {
				{
					filetype = "NvimTree",
					text = "",
					text_align = "center",
					separator = true,
				},
			},
		},
	},
}
