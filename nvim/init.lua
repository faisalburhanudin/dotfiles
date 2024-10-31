-- Set <space> as the leader key
vim.g.mapleader = " "

-- Install `lazy.nvim` plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

---@diagnostic disable-next-line: undefined-field
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- [[ Configure plugins ]]
require("lazy").setup({
	{
		import = "custom.plugins",
		change_detection = {
			notify = false,
		},
	},
})

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require("cmp")
local luasnip = require("luasnip")
-- require("luasnip.loaders.from_vscode").load()
require("luasnip.loaders.from_lua").load({
	paths = { vim.fn.stdpath("config") .. "/snippets" },
})
luasnip.config.setup({})

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	completion = {
		completeopt = "menu,menuone,noinsert",
	},
	mapping = cmp.mapping.preset.insert({
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete({}),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.insert,
			select = true,
		}),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "path" },
	},
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- python = { "isort", "black" },
		javascript = { { "prettierd", "prettier" } },
		sh = { "shfmt" },
		go = { "goimports", "gofmt" },
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

local lspconfig = require("lspconfig")

-- yank to system clipboard
vim.api.nvim_set_keymap("v", "<leader>y", '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>Y", '"+yg_', { noremap = true, silent = true })

-- paste from system clipboard
vim.api.nvim_set_keymap("n", "<leader>p", '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>P", '"+P', { noremap = true, silent = true })

-- jk to escape
vim.api.nvim_set_keymap("i", "jk", "<esc>", { noremap = true, silent = true })

-- wk to save and quit
vim.api.nvim_set_keymap("n", "<leader>wk", ":wq<CR>", { noremap = true, silent = true })

-- \ to split vertically
vim.api.nvim_set_keymap("n", "<leader>\\", ":vsplit<CR>", { noremap = true, silent = true })

-- - to split horizontally
vim.api.nvim_set_keymap("n", "<leader>-", ":split<CR>", { noremap = true, silent = true })

-- find and Replace
vim.api.nvim_set_keymap("n", "<leader>fr", ":%s//g<Left><Left>", { noremap = true, silent = true })

-- save
vim.api.nvim_set_keymap("n", "<leader>w", ":w<CR>", { noremap = true, silent = true })

local util = require("lspconfig.util")

lspconfig.dartls.setup({
	cmd = { "dart", "language-server", "--protocol=lsp" },
	filetypes = { "dart" },
	root_dir = util.root_pattern("pubspec.yaml"),
	init_options = {
		onlyAnalyzeProjectsWithOpenFiles = true,
		suggestFromUnimportedLibraries = true,
		closingLabels = true,
		outline = true,
		flutterOutline = true,
	},
	settings = {
		dart = {
			completeFunctionCalls = true,
			showTodos = true,
		},
	},
})

-- This is your opts table
require("telescope").setup({
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({
				-- even more opts
			}),

			-- pseudo code / specification for writing custom displays, like the one
			-- for "codeactions"
			-- specific_opts = {
			--   [kind] = {
			--     make_indexed = function(items) -> indexed_items, width,
			--     make_displayer = function(widths) -> displayer
			--     make_display = function(displayer) -> function(e)
			--     make_ordinal = function(e) -> string
			--   },
			--   -- for example to disable the custom builtin "codeactions" display
			--      do the following
			--   codeactions = false,
			-- }
		},
	},
})
-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("ui-select")

-- replace ; with :
vim.api.nvim_set_keymap("n", ";", ":", { noremap = true })
