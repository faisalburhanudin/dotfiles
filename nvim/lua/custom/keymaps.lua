local set = vim.keymap.set

-- yank to system clipboard
set("v", "<leader>y", '"+y')
set("n", "<leader>Y", '"+yg_')

-- paste from system clipboard
set("n", "<leader>p", '"+p')
set("n", "<leader>P", '"+P')

-- alternative escape
set("i", "jk", "<esc>")

-- alternative : with ;
set("n", ";", ":")

-- Oil
local oil = require("oil")
set("n", "<leader>o", oil.open)

-- Telescope
local builtin = require("telescope.builtin")
set("n", "<leader><space>", builtin.buffers, { desc = "[ ] Find existing buffers" })
set("n", "<leader>s/", builtin.current_buffer_fuzzy_find, { desc = "[S]earch [/] in Open Files" })
set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
set("n", "<leader>gf", builtin.git_files, { desc = "Search [G]it [F]iles" })
set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
set("n", "<leader>su", builtin.git_status, { desc = "[S]earch [U]nstash" })

-- yank to system clipboard
set("v", "<leader>y", '"+y')

-- Remap for dealing with word wrap
set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
