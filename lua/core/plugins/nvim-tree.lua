local function open_nvim_tree(data)
	local directory = vim.fn.isdirectory(data.file) == 1
	if directory then
		vim.cmd.cd(data.file)
		require("nvim-tree.api").tree.open()
		return
	end

	local real_file = vim.fn.filereadable(data.file) == 1
	if real_file then
		vim.cmd.cd("%:p:h")
	end
end

return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	lazy = false,
	config = function()
		require("nvim-tree").setup({
			renderer = {
				group_empty = true,
				indent_width = 1,
			},
			update_focused_file = {
				enable = true,
			},
			git = {
				ignore = false,
			},
			diagnostics = {
				enable = true,
			},
		})

		vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
	end,
	keys = {
		{
			"<C-n>",
			":NvimTreeToggle<CR>",
			desc = "Toggle file explorer",
			silent = true,
		},
	},
}
