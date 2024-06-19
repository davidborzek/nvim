local function go_to_nth_buffer(num)
	return {
		"<leader>" .. num,
		":lua require'bufferline'.go_to(" .. num .. ", true)<CR>",
		desc = "which_key_ignore",
		silent = true,
	}
end

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
	keys = {
		go_to_nth_buffer(1),
		go_to_nth_buffer(2),
		go_to_nth_buffer(3),
		go_to_nth_buffer(4),
		go_to_nth_buffer(5),
		go_to_nth_buffer(6),
		go_to_nth_buffer(7),
		go_to_nth_buffer(8),
		go_to_nth_buffer(9),
	},
}
