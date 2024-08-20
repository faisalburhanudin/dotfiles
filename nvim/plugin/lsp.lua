local nmap = function(keys, func, desc)
	if desc then
		desc = "LSP: " .. desc
	end

	vim.keymap.set("n", keys, func, { desc = desc })
end

-- document existing key chains
require("which-key").register({
	["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
	["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
	["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
	["<leader>h"] = { name = "Git [H]unk", _ = "which_key_ignore" },
	["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
	["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
	["<leader>t"] = { name = "[T]oggle", _ = "which_key_ignore" },
	["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
})

local builtin = require("telescope.builtin")
local buf = vim.lsp.buf

nmap("<leader>rn", buf.rename, "[R]e[n]ame")
nmap("<leader>ca", buf.code_action, "[C]ode [A]ction")
nmap("gd", builtin.lsp_definitions, "[G]oto [D]efinition")
nmap("gr", builtin.lsp_references, "[G]oto [R]eferences")
nmap("gI", builtin.lsp_implementations, "[G]oto [I]mplementation")
nmap("<leader>D", builtin.lsp_type_definitions, "Type [D]efinition")
nmap("<leader>ds", builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
nmap("<leader>ws", builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
nmap("K", buf.hover, "Hover Documentation")
nmap("<C-k>", buf.signature_help, "Signature Documentation")
nmap("gD", buf.declaration, "[G]oto [D]eclaration")

require("mason").setup()
require("mason-lspconfig").setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

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

local mason_lspconfig = require("mason-lspconfig")

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
			"--out-format",
			"json",
		},
	},
})

lspconfig.ruby_lsp.setup({
	capabilities = capabilities,
	cmd = { "/Users/faisal/.rbenv/shims/ruby-lsp" },
})
