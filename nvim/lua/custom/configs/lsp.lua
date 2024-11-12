local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local lspconfig = require("lspconfig")

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

lspconfig.ruby_lsp.setup({
	capabilities = capabilities,
	cmd = { "/Users/faisal/.rbenv/shims/ruby-lsp" },
})
