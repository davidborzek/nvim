local utils = require("core.utils.common")

local home = os.getenv("HOME")
local vault_password_script = home .. "/.config/nvim/scripts/ansible-vault-pw.sh"

local M = {}

local function ask_vault_password()
	local pw = vim.fn.inputsecret("Vault Password: ")
	vim.fn.setenv("ANSIBLE_VAULT_PASS", pw)
end

local function clear_vault_password()
	vim.fn.setenv("ANSIBLE_VAULT_PASS", "")
end

local function vault_cmd(cmd, args, stdin)
	local output =
		vim.fn.system("ansible-vault " .. cmd .. " --vault-pass-file " .. vault_password_script .. " " .. args, stdin)

	output = output:gsub("\n[^\n]*$", "")

	if vim.v.shell_error ~= 0 then
		vim.notify(utils.split_by_line(output), "error", { title = "Ansible Vault" })
		return nil
	end

	return output
end

local function create_encrypted_vault_buffer(name, buftype, content)
	vim.cmd("enew")
	vim.cmd("set buftype=" .. buftype)
	vim.cmd("set ft=yaml")

	local buf = vim.api.nvim_get_current_buf()

	vim.api.nvim_buf_set_name(buf, "ansible-vault " .. name)
	vim.api.nvim_buf_set_lines(buf, 0, -1, true, utils.split_by_line(content))

	return buf
end

function M.vault_edit()
	ask_vault_password()

	local encrypted_buf = vim.api.nvim_get_current_buf()
	local path = vim.fn.expand("%:p")

	local decrypted = vault_cmd("decrypt", "--output - " .. path)
	if decrypted == nil then
		clear_vault_password()
		return
	end

	local buf = create_encrypted_vault_buffer("view", "acwrite", decrypted)

	vim.api.nvim_create_augroup("AnsibleVault", { clear = false })
	vim.api.nvim_clear_autocmds({ buffer = buf, group = "AnsibleVault" })
	vim.api.nvim_create_autocmd("BufWriteCmd", {
		group = "AnsibleVault",
		buffer = buf,
		callback = function()
			local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
			if decrypted == table.concat(lines, "\n") then
				vim.cmd("bdelete! " .. buf)
				clear_vault_password()
				return
			end
			local encrypted = vault_cmd("encrypt", "--output -", lines)
			clear_vault_password()
			if encrypted == nil then
				return
			end
			vim.api.nvim_buf_set_lines(encrypted_buf, 0, -1, true, utils.split_by_line(encrypted))
			vim.cmd("bdelete! " .. buf)
		end,
	})
end

function M.vault_view()
	ask_vault_password()

	local path = vim.fn.expand("%:p")
	local decrypted = vault_cmd("decrypt", "--output - " .. path)
	clear_vault_password()
	if decrypted == nil then
		return
	end

	create_encrypted_vault_buffer("view", "nofile", decrypted)
end

function M.vault_decrypt()
	ask_vault_password()

	local path = vim.fn.expand("%:p")
	local decrypted = vault_cmd("decrypt", "--output - " .. path)
	clear_vault_password()
	if decrypted == nil then
		return
	end
	local buf = vim.api.nvim_get_current_buf()
	vim.api.nvim_buf_set_lines(buf, 0, -1, true, utils.split_by_line(decrypted))
end

function M.vault_encrypt()
	ask_vault_password()

	local path = vim.fn.expand("%:p")
	local encrypted = vault_cmd("encrypt", "--output - " .. path)
	clear_vault_password()
	if encrypted == nil then
		return
	end
	local buf = vim.api.nvim_get_current_buf()
	vim.api.nvim_buf_set_lines(buf, 0, -1, true, utils.split_by_line(encrypted))
end

return M
