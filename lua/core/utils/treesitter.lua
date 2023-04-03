local ts = require("nvim-treesitter.ts_utils")

local M = {}

local find_node_by_type = function(node, type)
	while node do
		if node:type() == type then
			return node
		end

		node = node:parent()
	end
	return node
end

local find_child_by_type = function(node, type)
	local child_id = 0
	local child = node:child(child_id)

	while child do
		--print(child:type())
		if child:type() == type then
			return child
		end

		child_id = child_id + 1
		child = node:child(child_id)
	end
	return child
end

-- finds the name of a child in node for a given
-- node type and child type
M.find_child_node_name_by_type = function(node_type, child_type)
	local current_node = ts.get_node_at_cursor()
	if not current_node then
		return nil
	end

	local method_node = find_node_by_type(current_node, node_type)
	if not method_node then
		return nil
	end

	local identifier = find_child_by_type(method_node, child_type)
	if not identifier then
		return nil
	end

	return vim.treesitter.query.get_node_text(identifier, 0)
end

return M
