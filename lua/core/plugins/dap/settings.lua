local dap = require("dap")

local M = {}

local map = vim.keymap.set

M.setup = function(opts)
	opts = opts or {}

	vim.api.nvim_set_hl(0, "DapBreakbointColor", { fg = "#ff0000" })
	vim.fn.sign_define("DapBreakpoint", { text = "⬤", texthl = "DapBreakbointColor", linehl = "", numhl = "" })

	dap.listeners.after.event_initialized["dap_config"] = function()
		if opts.open_repl then
			dap.repl.open()
		end
	end

	map("n", "<leader>ds", ":lua require'dap'.continue()<CR>", { desc = "Start", silent = true })
	map("n", "<leader>dl", ":lua require'dap'.run_last()<CR>", { desc = "Start last", silent = true })
	map("n", "<leader>dt", ":lua require'dap'.terminate()<CR>", { desc = "Terminate", silent = true })
	map("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<CR>", { desc = "Toggle breakpoint", silent = true })
	map("n", "<leader>do", ":lua require'dap'.step_over()<CR>", { desc = "Step over", silent = true })
	map("n", "<leader>di", ":lua require'dap'.step_into()<CR>", { desc = "Step into", silent = true })
	map("n", "<leader>dO", ":lua require'dap'.step_out()<CR>", { desc = "Step out", silent = true })
	map("n", "<leader>dr", ":lua require'dap'.repl.toggle()<CR>", { desc = "Toggle DAP repl", silent = true })
end

return M
