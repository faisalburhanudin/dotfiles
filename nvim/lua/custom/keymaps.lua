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
nmap("<leader>s/", builtin.current_buffer_fuzzy_find, "Search [/] in Open Files")
nmap("<leader>ss", builtin.builtin, "Search Select Telescope")
nmap("<leader>gf", builtin.git_files, "Search Git Files")
nmap("<leader>sh", builtin.help_tags, "Search Help")
nmap("<leader>sw", builtin.grep_string, "Search current Word")
nmap("<leader>sg", builtin.live_grep, "Search by Grep")
nmap("<leader>sd", builtin.diagnostics, "Search Diagnostics")
nmap("<leader>sr", builtin.resume, "Search Resume")
nmap("<leader>sf", builtin.find_files, "Search Files")
nmap("<leader>su", builtin.git_status, "Search Unstash")

-- yank to system clipboard
set("v", "<leader>y", '"+y')

-- yank to system clipboard, filepath and linenubmer, example: hello.go:123
set("n", "<leader>fl", function()
	local path = vim.fn.expand("%:p")
	local line = vim.fn.line(".")
	local text = string.format("%s:%d", path, line)
	vim.fn.setreg("+", text)
end, { desc = "Yank filepath:line to clipboard" })

-- Diagnostic keymaps
nmap("[d", vim.diagnostic.goto_prev, "Go to previous diagnostic message")
nmap("]d", vim.diagnostic.goto_next, "Go to next diagnostic message")
nmap("<leader>e", vim.diagnostic.open_float, "Open floating diagnostic message")
nmap("<leader>q", vim.diagnostic.setloclist, "Open diagnostics list")

-- LSP
local buf = vim.lsp.buf
nmap("<leader>rn", buf.rename, "Rename")
nmap("<leader>ca", buf.code_action, "Code Action")
nmap("gd", builtin.lsp_definitions, "Goto Definition")
nmap("gr", builtin.lsp_references, "Goto References")
nmap("gI", builtin.lsp_implementations, "Goto Implementation")
nmap("<leader>D", builtin.lsp_type_definitions, "Type Definition")
nmap("<leader>ds", builtin.lsp_document_symbols, "Document Symbols")
nmap("<leader>ws", builtin.lsp_dynamic_workspace_symbols, "Workspace Symbols")
nmap("K", buf.hover, "Hover Documentation")
nmap("<C-k>", buf.signature_help, "Signature Documentation")
nmap("gD", buf.declaration, "Goto Declaration")

-- NOTE: builtin keymaps I always forget
-- gf	: Open file Under cursor
-- C-x	: Increase
-- C-a	: Decrease
-- r	: replace single character
