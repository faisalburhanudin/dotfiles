require("mason").setup()

local mason_lspconfig = require("mason-lspconfig")

local servers = {
	gopls = {},
	pyright = {},
	html = { filetypes = { "html", "twig", "hbs" } },
	bashls = {},
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},

	-- Mason distributions is not working
	-- don't use it
	-- golangci_lint_ls = {},
}

mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
			settings = servers[server_name],
			filetypes = (servers[server_name] or {}).filetypes,
		})
	end,
})
