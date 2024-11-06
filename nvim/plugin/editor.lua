-- highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

local oil = require("oil")
oil.setup()

-- open current file in oil
vim.api.nvim_set_keymap("n", "<leader>o", "<cmd>lua require('oil').open()<CR>", { noremap = true, silent = true })

-- toggle flash
vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>lua require('flash').toggle()<CR>", { noremap = true, silent = true })
require("flash").toggle()

-- require("aerial").setup({
-- 	-- optionally use on_attach to set keymaps when aerial has attached to a buffer
-- 	on_attach = function(bufnr)
-- 		-- Jump forwards/backwards with '{' and '}'
-- 		-- vim.keymap.set("n", "{a", "<cmd>AerialPrev<CR>", { buffer = bufnr })
-- 		-- vim.keymap.set("n", "}a", "<cmd>AerialNext<CR>", { buffer = bufnr })
-- 	end,
-- })
-- You probably also want to set a keymap to toggle aerial
vim.keymap.set("n", "<leader>at", "<cmd>AerialToggle!<CR>")
-- disable flash on csv
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.csv",
	callback = function()
		require("flash").toggle(false)
	end,
})

local debugprint = require("debugprint")
debugprint.setup()

-- Command to copy path
vim.api.nvim_create_user_command("Cppath", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	vim.notify("Copied path to clipboard: " .. path)
end, {})
