require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		javascript = { { "prettierd", "prettier" } },
		sh = { "shfmt" },
		go = { "goimports", "gofmt" },
	},
})
