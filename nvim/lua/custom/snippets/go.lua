local ls = require("luasnip")
local s = ls.s
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node

-- snippet always used at buffer 0
local bufnr = 0

local function get_node_text(node)
	return vim.treesitter.get_node_text(node, 0)
end

--- Get TSNode for [err]
--- example:
---    err := foo()
--- it will locate TSNode at [err]
--- @return TSNode?
local function get_node_at_err()
	-- we cannot use ts_utils.get_node_at_cursor because when snippet running, TSNode is not yet created
	-- this will make block node selected, so we need to locate it with position
	local cursor_pos = vim.api.nvim_win_get_cursor(bufnr)

	-- TSNode index is start from 0
	-- Lua index is start from 1
	-- thats why we need to subtract with -2 to get row above
	local row = cursor_pos[1] - 2
	local col = cursor_pos[2]

	local parser = vim.treesitter.get_parser(bufnr)
	local tree = parser:parse()[1]
	local root = tree:root()

	local node = root:named_descendant_for_range(row, col, row, col)
	return node
end

local function get_caller(err_node)
	local node = err_node

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

--- @param err_node TSNode
local function get_function_name(err_node)
	local node = err_node
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
	local err_node = get_node_at_err()
	if err_node == nil then
		return
	end

	local caller = get_caller(err_node)
	local function_name = get_function_name(err_node)

	local msg = '"error at ' .. caller .. "() when call " .. function_name .. '() error: %s", err'
	return "log.Fatalf(" .. msg .. ")"
end

return {
	s("iferr", {
		t({ "if err != nil {", "\t" }),
		f(err_handler, {}),
		i(0),
		t({ "", "}" }),
	}),

	s("pan", { t('panic("implement me!")') }),
}
