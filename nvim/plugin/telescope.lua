-- enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

local set = vim.keymap.set
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
