local M = {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/vim-vsnip",
	},
	config = function()
		local cmp = require("cmp")

		cmp.setup({
			mapping = {
				["<S-Tab>"] = cmp.mapping.select_prev_item(),
				["<Tab>"] = cmp.mapping.select_next_item(),
				["<C-S-f>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.close(),
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Insert,
					select = true,
				}),
			},

			snippet = {
				expand = function(args)
					vim.fn["vsnip#anonymous"](args.body)
				end,
			},

			sources = {
				{ name = "path" },
				{ name = "nvim_lsp", keyword_length = 3 },
				{ name = "nvim_lsp_signature_help" },
				{ name = "nvim_lua", keyword_length = 2 },
				{ name = "buffer", keyword_length = 2 },
				{ name = "vsnip", keyword_length = 2 },
			},

			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},

			formatting = {
				fields = { "menu", "abbr", "kind" },
				format = function(entry, item)
					local menu_icon = {
						nvim_lsp = "λ",
						vsnip = "⋗",
						buffer = "b",
						path = "p",
					}
					item.menu = menu_icon[entry.source.name]
					return item
				end,
			},
		})
	end,
}

return M
