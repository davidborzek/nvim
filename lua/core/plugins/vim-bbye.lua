return {
	"vds2212/vim-bbye",
	cmd = "Bdelete",
	keys = {
		{
			"<C-x>",
			"<cmd>Bdelete<cr>",
			desc = "Close current buffer",
			silent = true,
		},
		{
			"<leader>x",
			"<cmd>Bdelete<cr>",
			desc = "Close current buffer",
			silent = true,
		},
		{
			"<leader>X",
			":bufdo :Bdelete<cr>",
			desc = "Close all buffers",
			silent = true,
		},
	},
}
