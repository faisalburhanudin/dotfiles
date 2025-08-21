-- run conform to format before save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

-- setup python formatting on save for mcp-getgather project
require("custom.utils").python_format.setup_autocmd()

