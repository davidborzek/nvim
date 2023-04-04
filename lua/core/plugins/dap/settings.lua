local dap = require("dap")

local M = {}

local map = vim.keymap.set

M.setup = function()
	vim.api.nvim_set_hl(0, "DapBreakbointColor", { fg = "#ff0000" })
	vim.fn.sign_define("DapBreakpoint", { text = "⬤", texthl = "DapBreakbointColor", linehl = "", numhl = "" })

	map("n", "<leader>dc", ":lua require'dap'.continue()<CR>", { desc = "Start debugging", silent = true })
	map("n", "<leader>dt", ":lua require'dap'.terminate()<CR>", { desc = "Stop debugging", silent = true })
	map("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<CR>", { desc = "Toggle breakpoint", silent = true })
	map("n", "<leader>do", ":lua require'dap'.step_over()<CR>", { desc = "Step over", silent = true })
	map("n", "<leader>di", ":lua require'dap'.step_into()<CR>", { desc = "Step into", silent = true })
	map("n", "<leader>dO", ":lua require'dap'.step_out()<CR>", { desc = "Step out", silent = true })
	map("n", "<leader>dr", ":lua require'dap'.repl.toggle()<CR>", { desc = "Toggle DAP repl", silent = true })
end

return M
