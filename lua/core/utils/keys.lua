local M = {}

-- map keys for a specific buffer
-- takes a buffer number and a callbac with a map function
function M.map_buffer_keys(buffer, cb)
	local map = function(mode, key, cmd, desc)
		vim.keymap.set(mode, key, cmd, {
			silent = true,
			buffer = buffer,
			desc = desc,
		})
	end

	cb(map)
end

return M
