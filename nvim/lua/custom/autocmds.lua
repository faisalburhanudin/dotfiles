-- run conform to format before save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

-- disable flash on csv file
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.csv",
	callback = function()
		require("flash").toggle(false)
	end,
})
