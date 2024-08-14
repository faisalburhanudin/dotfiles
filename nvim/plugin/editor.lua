-- Set theme
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

-- Set tab_width
vim.o.tabstop = 4

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.o.relativenumber = true

-- no wrap
vim.wo.wrap = false

-- no swap file
vim.o.swapfile = false

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

-- require("autoclose").setup({
-- 	options = {
-- 		disable_when_touch = true,
-- 		-- currently it only works for begin character, it will be great if it works for end character
-- 		touch_regex = "%w",
-- 	},
-- })
--
-- disable flash on csv
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.csv",
	callback = function()
		require("flash").toggle(false)
	end,
})

local debugprint = require("debugprint")
debugprint.setup()
