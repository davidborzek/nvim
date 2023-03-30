return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- extensions
		"nvim-telescope/telescope-ui-select.nvim",
	},
	cmd = "Telescope",
	tag = "0.1.0",
	keys = {
		-- file / buffer commands
		{
			"<leader>f",
			"<cmd>Telescope find_files<CR>",
			desc = "Search files",
			silent = true,
		},
		{
			"<leader>s",
			"<cmd>Telescope live_grep<CR>",
			desc = "Live grep",
			silent = true,
		},
		{
			"<leader>b",
			"<cmd>Telescope buffers<CR>",
			desc = "Show buffers",
			silent = true,
		},
		-- git commands
		{
			"<leader>gc",
			"<cmd>Telescope git_commits<CR>",
			desc = "Git commit",
			silent = true,
		},
		{
			"<leader>gb",
			"<cmd>Telescope git_branches<CR>",
			desc = "Git branches",
			silent = true,
		},
		{
			"<leader>gs",
			"<cmd>Telescope git_status<CR>",
			desc = "Git status",
			silent = true,
		},
		{
			"<leader>gf",
			"<cmd>Telescope git_files<CR>",
			desc = "Git files",
			silent = true,
		},
	},
	opts = {
		defaults = {
			path_display = {
				shorten = { len = 1, exclude = { 1, -1 } },
			},
			dynamic_preview_title = true,
			mappings = {
				i = {
					["<C-Down>"] = function(...)
						return require("telescope.actions").cycle_history_next(...)
					end,
					["<C-Up>"] = function(...)
						return require("telescope.actions").cycle_history_prev(...)
					end,
				},
			},
			layout_strategy = "bottom_pane",
			layout_config = {
				height = 0.4,
			},
			borderchars = {
				prompt = { "─", " ", " ", " ", " ", " ", " ", " " },
				results = { "─", " ", " ", " ", " ", " ", " ", " " },
				preview = { " ", " ", " ", " ", " ", " ", " ", " " },
			},
			results_title = false,
			sorting_strategy = "ascending",
		},
		pickers = {
			find_files = {
				hidden = true,
				no_ignore = true,
				file_ignore_patterns = { ".git/" },
			},
		},
	},
}
