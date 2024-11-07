local function keymap(mode, lhs, rhs)
	vim.api.nvim_set_keymap(mode, lhs, rhs, { noremap = true, silent = true })
end

-- yank to system clipboard
keymap("v", "<leader>y", '"+y')
keymap("n", "<leader>Y", '"+yg_')

-- paste from system clipboard
keymap("n", "<leader>p", '"+p')
keymap("n", "<leader>P", '"+P')

-- alternative escape
keymap("i", "jk", "<esc>")

-- wk to save and quit
keymap("n", "<leader>wk", ":wq<CR>")

-- \ to split vertically
keymap("n", "<leader>\\", ":vsplit<CR>")

-- - to split horizontally
keymap("n", "<leader>-", ":split<CR>")

-- find and Replace
keymap("n", "<leader>fr", ":%s//g<Left><Left>")

-- save
keymap("n", "<leader>w", ":w<CR>")
