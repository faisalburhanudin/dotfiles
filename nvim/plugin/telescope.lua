-- enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
