local on_attach = function(buffer)
	local function map(mode, l, r, desc)
		vim.keymap.set(mode, l, r, { buffer = buffer, silent = true, desc = desc })
	end

	map("n", "<leader>ghp", ":Gitsigns preview_hunk<CR>", "Preview hunk")
	map("n", "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset hunk")
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
