require("grapple").setup({
	scope = "git",
})

vim.keymap.set("n", "<leader>m", "<cmd>Grapple toggle<cr>", { desc = "Grapple toggle tag" })
vim.keymap.set("n", "<leader>M", "<cmd>Grapple toggle_tags<cr>", { desc = "Grapple open tags window" })
vim.keymap.set("n", "<leader>n", "<cmd>Grapple cycle_tags next<cr>", { desc = "Grapple cycle next tag" })
vim.keymap.set("n", "<leader>p", "<cmd>Grapple cycle_tags prev<cr>", { desc = "Grapple cycle previous tag" })