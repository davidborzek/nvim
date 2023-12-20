local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- toggle autoformating (default is true)
local autoformat = true

-- lsp formatting using null-ls
local format = function(bufnr)
	if not autoformat then
		return
	end

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

local function eslint_condition(utils)
	return utils.root_has_file({
		"eslint.config.js",
		".eslintrc",
		".eslintrc.js",
		".eslintrc.cjs",
		".eslintrc.yaml",
		".eslintrc.yml",
		".eslintrc.json",
	})
end

return {
	"jose-elias-alvarez/null-ls.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local null_ls = require("null-ls")

		vim.api.nvim_create_user_command("AutoformatToggle", function()
			autoformat = not autoformat
			vim.notify(autoformat and "Auto-format enabled" or "Auto-format disabled", "info", { title = "Format" })
		end, { desc = "Toggles autoformatting" })

		null_ls.setup({
			on_attach = on_attach,
			sources = {
				-- eslint
				null_ls.builtins.diagnostics.eslint.with({
					condition = eslint_condition,
				}),
				null_ls.builtins.code_actions.eslint.with({
					condition = eslint_condition,
				}),
				-- golang
				null_ls.builtins.diagnostics.staticcheck,
				null_ls.builtins.formatting.gofmt,
				null_ls.builtins.formatting.goimports,
				-- prettier
				null_ls.builtins.formatting.prettier,
				-- shell / bash
				null_ls.builtins.formatting.shfmt,
				-- lua
				null_ls.builtins.formatting.stylua,
				-- rust
				null_ls.builtins.formatting.rustfmt,
				-- java
				null_ls.builtins.formatting.google_java_format,
			},
		})
	end,
}
