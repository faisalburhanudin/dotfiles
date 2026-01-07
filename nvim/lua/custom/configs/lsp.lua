-- Setup Mason first
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"gopls",
		"pyright",
		"html",
		"bashls",
		"ts_ls",
		"typos_lsp",
		-- "ruby_lsp",
		"golangci_lint_ls",
	},
	automatic_installation = true,
})

-- Setup Mason tool installer for formatters
require("mason-tool-installer").setup({
	ensure_installed = {
		"prettierd",
		"prettier",
		"stylua",
		"ruff",
	},
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("blink.cmp").get_lsp_capabilities()

local lspconfig = require("lspconfig")

-- golang
lspconfig.gopls.setup({
	capabilities = capabilities,
})

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
lspconfig.pyright.setup({
	capabilities = capabilities,
})

-- html
lspconfig.html.setup({
	capabilities = capabilities,
})

-- bash
lspconfig.bashls.setup({
	capabilities = capabilities,
})

-- lua
lspconfig.lua_ls.setup({
	capabilities = capabilities,
})

-- typescript/javascript
lspconfig.ts_ls.setup({
	capabilities = capabilities,
	root_dir = lspconfig.util.root_pattern("pnpm-workspace.yaml", "pnpm-lock.yaml", ".git"),
	single_file_support = false,
})

-- typos
lspconfig.typos_lsp.setup({
	capabilities = capabilities,
	init_options = {
		config = "~/.config/typos/typos.toml",
	},
})

-- ruby
lspconfig.ruby_lsp.setup({
	capabilities = capabilities,
	cmd = { "/Users/faisal/.rbenv/shims/ruby-lsp" },
})
