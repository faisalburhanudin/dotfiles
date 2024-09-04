local ls = require("luasnip")
local s = ls.s
local t = ls.text_node

return {
	s("ipd", {
		t("import pandas as pd"),
	}),

	s("ireq", {
		t("import requests"),
	}),
}
