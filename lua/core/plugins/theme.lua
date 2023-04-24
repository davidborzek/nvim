local bg = "#0b0a10"

return {
	"Mofiqul/dracula.nvim",
	priority = 1000,
	config = function()
		require("dracula").setup({
			colors = {
				bg = bg,
				menu = bg,
				selection = "#685E97",
			},
			lualine_bg_color = bg,
			overrides = {
				BufferLineFill = { bg = bg },
			},
		})
		vim.cmd("colorscheme dracula")
	end,
}
