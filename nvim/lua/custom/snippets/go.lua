local ts_utils = require("nvim-treesitter.ts_utils")
local ls = require("luasnip")
local s = ls.s
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node

local function get_node_text(node)
	return vim.treesitter.get_node_text(node, 0)
end

local function get_caller()
	local node = ts_utils.get_node_at_cursor()
	if not node then
		return
	end

	while node do
		if node:type() == "function_declaration" then
			local name_node = node:field("name")[1]
			local function_name = vim.treesitter.get_node_text(name_node, 0)
			return function_name
		end
		node = node:parent()
	end

	return ""
end

local function get_node_by_position(bufnr, row, col)
	local parser = vim.treesitter.get_parser(bufnr)
	local tree = parser:parse()[1]
	local root = tree:root()

	local node = root:named_descendant_for_range(row - 1, col, row - 1, col)
	return node
end

local function get_function_name()
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	local row = cursor_pos[1]
	local col = cursor_pos[2]

	local node = get_node_by_position(0, row - 1, col)

	while node do
		if node:type() == "short_var_declaration" then
			local right_node = node:field("right")[1]
			if not right_node then
				return
			end

			for child_node in right_node:iter_children() do
				if child_node:type() == "call_expression" then
					local function_node = child_node:field("function")[1]
					return get_node_text(function_node)
				end
			end
		end

		local parent_node = node:parent()
		if not parent_node then
			return
		end

		node = parent_node
	end
end

local function err_handler(_, _, _)
	local msg = '"error at ' .. get_caller() .. "() when call " .. get_function_name() .. '() error: %w", err'
	return "log.Fatalf(" .. msg .. ")"
end

return {
	s("ier", {
		t({ "if err != nil {", "\t" }),
		f(err_handler, {}),
		i(0),
		t({ "", "}" }),
	}),
}
