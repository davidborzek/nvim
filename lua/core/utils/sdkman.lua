local settings = require("core.settings")

local M = {}

M.get_installed_java_versions = function()
	local path = settings.sdkman_path .. "/candidates/java"

	if not vim.loop.fs_stat(path) then
		return
	end

	local handle = vim.loop.fs_scandir(path)
	if not handle then
		return
	end

	local versions = {}
	while true do
		local name, t = vim.loop.fs_scandir_next(handle)
		if not name then
			break
		end

		if t == "directory" then
			local v = "JavaSE-"
			if string.sub(name, 2, 2) == "." then
				v = v .. "1." .. string.sub(name, 1, 1)
			else
				v = v .. string.sub(name, 1, 2)
			end

			local version = {
				path = path .. "/" .. name,
				name = v,
			}

			table.insert(versions, version)
		end

		if t == "link" and name == "current" then
			print(name)
		end
	end

	return versions
end

return M
