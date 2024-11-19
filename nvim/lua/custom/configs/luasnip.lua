local from_lua = require("luasnip.loaders.from_lua")

from_lua.load({
	paths = { "~/.config/nvim/lua/custom/snippets" },
})
