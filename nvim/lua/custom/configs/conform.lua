require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		javascript = { "prettierd", "prettier" },
		sh = { "shfmt" },
		go = { "goimports", "gofmt" },
		json = { "jq" },
	},
	formatters = {
		black = {
			prepend_args = { "--line-length", "100" },
		},
	},
})
