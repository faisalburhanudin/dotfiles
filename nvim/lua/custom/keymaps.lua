local set = vim.keymap.set

local function nmap(lhs, rhs, desc)
	set("n", lhs, rhs, { desc = desc })
end

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
nmap("<leader><space>", builtin.buffers, "[ ] Find existing buffers")
nmap("<leader>s/", builtin.current_buffer_fuzzy_find, "[S]earch [/] in Open Files")
nmap("<leader>ss", builtin.builtin, "[S]earch [S]elect Telescope")
nmap("<leader>gf", builtin.git_files, "Search [G]it [F]iles")
nmap("<leader>sh", builtin.help_tags, "[S]earch [H]elp")
nmap("<leader>sw", builtin.grep_string, "[S]earch current [W]ord")
nmap("<leader>sg", builtin.live_grep, "[S]earch by [G]rep")
nmap("<leader>sd", builtin.diagnostics, "[S]earch [D]iagnostics")
nmap("<leader>sr", builtin.resume, "[S]earch [R]esume")
nmap("<leader>sf", builtin.find_files, "[S]earch [F]iles")
nmap("<leader>su", builtin.git_status, "[S]earch [U]nstash")

-- yank to system clipboard
set("v", "<leader>y", '"+y')

-- Diagnostic keymaps
nmap("[d", vim.diagnostic.goto_prev, "Go to previous diagnostic message")
nmap("]d", vim.diagnostic.goto_next, "Go to next diagnostic message")
nmap("<leader>e", vim.diagnostic.open_float, "Open floating diagnostic message")
nmap("<leader>q", vim.diagnostic.setloclist, "Open diagnostics list")

-- LSP
local buf = vim.lsp.buf
nmap("<leader>rn", buf.rename, "[R]e[n]ame")
nmap("<leader>ca", buf.code_action, "[C]ode [A]ction")
nmap("gd", builtin.lsp_definitions, "[G]oto [D]efinition")
nmap("gr", builtin.lsp_references, "[G]oto [R]eferences")
nmap("gI", builtin.lsp_implementations, "[G]oto [I]mplementation")
nmap("<leader>D", builtin.lsp_type_definitions, "Type [D]efinition")
nmap("<leader>ds", builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
nmap("<leader>ws", builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
nmap("K", buf.hover, "Hover Documentation")
nmap("<C-k>", buf.signature_help, "Signature Documentation")
nmap("gD", buf.declaration, "[G]oto [D]eclaration")

-- NOTE: builtin keymaps I always forget
-- gf	: Open file Under cursor
-- C-x	: Increase
-- C-a	: Decrease
-- r	: replace single character
