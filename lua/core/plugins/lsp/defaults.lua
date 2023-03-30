local M = {}

function M.on_attach(client, buffer)
	local map = function(mode, key, cmd, desc)
		local opts = {
			silent = true,
			buffer = buffer,
			desc = desc,
		}
		vim.keymap.set(mode, key, cmd, opts)
	end

	-- leader key
	map("n", "<leader>lr", ':lua require"telescope.builtin".lsp_references()<CR>', "LSP references")
	map("n", "<leader>ld", ':lua require"telescope.builtin".lsp_definitions()<CR>', "LSP definitions")
	map("n", "<leader>li", ':lua require"telescope.builtin".lsp_implementations()<CR>', "LSP implementations")
	map("n", "<leader>lh", ':lua require"telescope.builtin".lsp_diagnostics()<CR>', "LSP diagnostics")
	map(
		"n",
		"<leader>lh",
		':lua  require"telescope.builtin".diagnostics({ bufnr = 0 })<CR>',
		"LSP diagnostics (current buffer))"
	)

	map("n", "gd", ':lua require"telescope.builtin".lsp_definitions()<CR>', "Go to definition")
	map("n", "gr", "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename occurrences")
end

return M
