local ls = require("luasnip")
local s = ls.s
local i = ls.insert_node
local t = ls.text_node

return {
	s("ier", {
		t("if err != nil {"),
		i(0),
		t("}"),
	}),
}
