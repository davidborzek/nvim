local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- lsp formatting using null-ls
local format = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
		timeout_ms = 2000,
	})
end

local on_attach = function(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				format(bufnr)
			end,
		})
	end
end

return {
	"jose-elias-alvarez/null-ls.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			on_attach = on_attach,
			sources = {
				-- eslint
				null_ls.builtins.diagnostics.eslint,
				null_ls.builtins.code_actions.eslint,
				-- golang
				null_ls.builtins.diagnostics.staticcheck,
				null_ls.builtins.formatting.gofmt,
				-- prettier
				null_ls.builtins.formatting.prettier,
				-- shell / bash
				null_ls.builtins.formatting.shfmt,
				-- lua
				null_ls.builtins.formatting.stylua,
				-- rust
				null_ls.builtins.formatting.rustfmt,
			},
		})
	end,
}
