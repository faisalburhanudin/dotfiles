local nmap = function(keys, func, desc)
	if desc then
		desc = "LSP: " .. desc
	end

	vim.keymap.set("n", keys, func, { desc = desc })
end

local builtin = require("telescope.builtin")
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
