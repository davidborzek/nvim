local create_user_command = vim.api.nvim_create_user_command

local ansible = require("core.utils.ansible")

create_user_command("AnsibleVaultEdit", function()
	ansible.vault_edit()
end, { desc = "Edit an ansible vault file." })

create_user_command("AnsibleVaultView", function()
	ansible.vault_view()
end, { desc = "View an ansible vault file." })

create_user_command("AnsibleVaultDecrypt", function()
	ansible.vault_decrypt()
end, { desc = "Decrypt an ansible vault file." })

create_user_command("AnsibleVaultEncrypt", function()
	ansible.vault_encrypt()
end, { desc = "Encrypt a file to ansible-vault file." })
