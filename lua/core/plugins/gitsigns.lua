local on_attach = function()
	vim.keymap.set("n", "<leader>gh", ":Gitsigns preview_hunk<CR>", { desc = "Preview hunk", silent = true })
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
