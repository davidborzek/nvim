local M = {}

-- wrapper to show git commits via telescope
-- notifies on errors
M.show_commits = function()
	if pcall(function()
		require("telescope.builtin").git_commits()
	end) == false then
		vim.notify({ "Failed to show commits.", "Probably not in a git repo." }, "error", { title = "Git" })
	end
end

-- wrapper to show git branches via telescope
-- notifies on errors
M.show_branches = function()
	if pcall(function()
		require("telescope.builtin").git_branches()
	end) == false then
		vim.notify({ "Failed to show branches.", "Probably not in a git repo." }, "error", { title = "Git" })
	end
end

-- wrapper to show git status via telescope
-- notifies on errors
M.show_status = function()
	if pcall(function()
		require("telescope.builtin").git_status()
	end) == false then
		vim.notify({ "Failed to show status.", "Probably not in a git repo." }, "error", { title = "Git" })
	end
end

-- wrapper to show git files via telescope
-- notifies on errors
M.show_files = function()
	if pcall(function()
		require("telescope.builtin").git_files()
	end) == false then
		vim.notify({ "Failed to show files.", "Probably not in a git repo." }, "error", { title = "Git" })
	end
end

return M
