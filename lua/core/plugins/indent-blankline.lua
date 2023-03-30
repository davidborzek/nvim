return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		show_trailing_blankline_indent = false,
		show_first_indent_level = false,
		show_current_context = false,
	},
}
