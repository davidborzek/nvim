local dap = require("dap")

local M = {}

local map = vim.keymap.set

local configuire = function()
	vim.api.nvim_set_hl(0, "DapBreakbointColor", { fg = "#ff0000" })
	vim.fn.sign_define("DapBreakpoint", { text = "⬤", texthl = "DapBreakbointColor", linehl = "", numhl = "" })
end

local configure_ui = function()
	local dapui = require("dapui")
	dapui.setup({})

	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close()
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close()
	end
end

M.setup = function()
	configuire()
	configure_ui()

	map("n", "<F5>", ":lua require'dap'.continue()<CR>", { desc = "Start debugging", silent = true })
	map("n", "<F4>", ":lua require'dap'.terminate()<CR>", { desc = "Stop debugging", silent = true })
	map("n", "<C-b>", ":lua require'dap'.toggle_breakpoint()<CR>", { desc = "Toggle breakpoint", silent = true })
	map("n", "<F10>", ":lua require'dap'.step_over()<CR>", { desc = "Step over", silent = true })
	map("n", "<F11>", ":lua require'dap'.step_into()<CR>", { desc = "Step into", silent = true })
	map("n", "<F12>", ":lua require'dap'.step_out()<CR>", { desc = "Step out", silent = true })
	map("n", "<F6>", ":lua require'dap'.repl.open()<CR>", { desc = "Open DAP repl", silent = true })

	map("n", "<C-d>", ":lua require'dapui'.toggle()<CR>", { desc = "Toggle DAP UI", silent = true })
end

return M
