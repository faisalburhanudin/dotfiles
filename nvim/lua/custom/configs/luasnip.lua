local loaders = require("luasnip.loaders.from_vscode")
local from_lua = require("luasnip.loaders.from_lua")

loaders.lazy_load()
from_lua.load({
	paths = { "~/.config/nvim/lua/custom/snippets" },
})
