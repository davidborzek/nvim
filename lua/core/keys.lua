local map = vim.keymap.set

local utils = require("core.utils.keys")

local M = {}

-- clear search on escape
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { silent = true })

-- exit
map("n", "<leader>q", ":qa<CR>", { desc = "Exit", silent = true })

-- exit and save all
map("n", "<leader>Q", ":wqa<CR>", { desc = "Exit and save all", silent = true })

-- save all
map("n", "<leader>w", ":wa<CR>", { desc = "Save all", silent = true })

-- copy to system clipboard
map("v", "<leader>c", '"+y', { desc = "Copy to system clipboard", silent = true })

-- open new terminal buffer
map("n", "<leader>T", ":terminal<CR>", { desc = "Open new terminal buffer", silent = true })

-- jump to next snippet selection
map("s", "<Tab>", "<cmd>lua require('luasnip').jump(1)<cr>", { desc = "Jump to next snippet selection", silent = true })

-- jump to previous snippet selection
map(
	"s",
	"<S-Tab>",
	"<cmd>lua require('luasnip').jump(-1)<cr>",
	{ desc = "Jump to previous snippet selection", silent = true }
)

-- Exit terminal mode
map("t", "<esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode", silent = true })

-- Close terminal buffer
map("t", "<C-q>", [[<C-\><C-n>:Bdelete!<CR>]], { desc = "Close terminal", silent = true })

-- map lsp keys used by on_attach
function M.map_lsp_keys(buffer)
	utils.map_buffer_keys(buffer, function(_map)
		_map("n", "K", ":lua vim.lsp.buf.hover()<CR>", "LSP docs")
		_map("n", "<leader>lk", ":lua vim.lsp.buf.hover()<CR>", "LSP docs")
		_map("n", "<leader>ln", ":lua vim.diagnostic.goto_next()<CR>", "LSP Go to next diagnostic")
		_map("n", "<leader>lN", ":lua vim.diagnostic.open_float()<CR>", "LSP Preview diagnostic")
		_map("n", "<leader>lr", ':lua require"telescope.builtin".lsp_references()<CR>', "LSP references")
		_map("n", "<leader>ld", ':lua require"telescope.builtin".lsp_definitions()<CR>', "LSP definitions")
		_map("n", "<leader>li", ':lua require"telescope.builtin".lsp_implementations()<CR>', "LSP implementations")
		_map("n", "<leader>lh", ':lua require"telescope.builtin".diagnostics()<CR>', "LSP diagnostics")
		_map(
			"n",
			"<leader>lH",
			':lua  require"telescope.builtin".diagnostics({ bufnr = 0 })<CR>',
			"LSP diagnostics (current buffer)"
		)

		_map("n", "gd", ':lua require"telescope.builtin".lsp_definitions()<CR>', "Go to definition")
		_map("n", "gr", "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename occurrences")
		_map({ "n", "i" }, "<A-Space>", "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code action")
	end)
end

-- map java lsp keys used by on_attach
function M.map_java_lsp_keys(buffer)
	utils.map_buffer_keys(buffer, function(_map)
		_map("n", "<leader>i", "<Cmd>lua require'jdtls'.organize_imports()<CR>", "Organize imports (Java)")
		_map("v", "<leader>em", "<Esc><Cmd>lua require'jdtls'.extract_method(true)<CR>", "Extract method (Java)")
		_map("n", "<leader>u", "<Cmd>lua require'jdtls'.update_project_config()<CR>", "Update project config (Java)")
	end)
end

-- map keys for debugging
function M.map_dap_keys()
	map("n", "<leader>ds", ":lua require'dap'.continue()<CR>", { desc = "Start", silent = true })
	map("n", "<leader>dl", ":lua require'dap'.run_last()<CR>", { desc = "Start last", silent = true })
	map("n", "<leader>dt", ":lua require'dap'.terminate()<CR>", { desc = "Terminate", silent = true })
	map("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<CR>", { desc = "Toggle breakpoint", silent = true })
	map("n", "<leader>do", ":lua require'dap'.step_over()<CR>", { desc = "Step over", silent = true })
	map("n", "<leader>di", ":lua require'dap'.step_into()<CR>", { desc = "Step into", silent = true })
	map("n", "<leader>dO", ":lua require'dap'.step_out()<CR>", { desc = "Step out", silent = true })
	map("n", "<leader>dr", ":lua require'dap'.repl.toggle()<CR>", { desc = "Toggle DAP repl", silent = true })
end

-- map key for git
function M.map_gitsigns_keys(buffer)
	utils.map_buffer_keys(buffer, function(_map)
		_map("n", "<leader>ghp", ":Gitsigns preview_hunk<CR>", "Preview hunk")
		_map("n", "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset hunk")
	end)
end

return M
