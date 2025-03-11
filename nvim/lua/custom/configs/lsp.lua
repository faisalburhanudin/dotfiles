local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local lspconfig = require("lspconfig")

-- golang
lspconfig.gopls.setup({})

lspconfig.golangci_lint_ls.setup({
	capabilities = capabilities,
	filetypes = { "go", "gomod" },
	root_dir = lspconfig.util.root_pattern("go.mod"),
	init_options = {
		command = {
			"golangci-lint",
			"run",
			"--no-config",
			"-E",
			"stylecheck",
			"--out-format",
			"json",
		},
	},
})

-- python
lspconfig.pyright.setup({})

-- html
lspconfig.html.setup({})

-- bash
lspconfig.bashls.setup({})

-- lua
lspconfig.lua_ls.setup({})

-- typos
lspconfig.typos_lsp.setup({
	init_options = {
		config = "~/.config/typos/typos.toml",
	},
})

-- ruby
lspconfig.ruby_lsp.setup({
	capabilities = capabilities,
	cmd = { "/Users/faisal/.rbenv/shims/ruby-lsp" },
})
