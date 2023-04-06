local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup("TermNoNumbers", { clear = true })
autocmd("TermOpen", {
	group = "TermNoNumbers",
	callback = function()
		vim.cmd("startinsert")
		vim.cmd("setlocal nonumber norelativenumber")
	end,
})
