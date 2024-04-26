-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Install `lazy.nvim` plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
	"almo7aya/openingh.nvim",
	"github/copilot.vim",
	"stevearc/conform.nvim",
	"folke/neodev.nvim",
	"folke/zen-mode.nvim",
	"petertriho/nvim-scrollbar",
	"nvim-telescope/telescope-ui-select.nvim",
	"nvim-lua/plenary.nvim",

	-- Git related plugins
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",

	-- Detect tabstop and shiftwidth automatically
	"tpope/vim-sleuth",

	-- Fast search
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},

	-- DAP
	"mfussenegger/nvim-dap",
	"rcarriga/nvim-dap-ui",

	-- Automatically close tags
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",

			-- Adds LSP completion capabilities
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",

			-- Adds a number of user-friendly snippets
			"rafamadriz/friendly-snippets",
		},
	},

	--  LSP related plugins
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			-- Useful status updates for LSP
			{ "j-hui/fidget.nvim", opts = {} },

			-- Additional lua configuration, makes nvim stuff amazing!
			"folke/neodev.nvim",
		},
	},

	-- Useful plugin to show you pending keybinds.
	{
		"folke/which-key.nvim",
		opts = {},
	},

	-- Adds git related signs to the gutter, as well as utilities for managing changes
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map({ "n", "v" }, "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "Jump to next hunk" })

				map({ "n", "v" }, "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "Jump to previous hunk" })

				--
				-- visual mode
				map("v", "<leader>hs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "stage git hunk" })
				map("v", "<leader>hr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "reset git hunk" })
				-- normal mode
				map("n", "<leader>hs", gs.stage_hunk, { desc = "git stage hunk" })
				map("n", "<leader>hr", gs.reset_hunk, { desc = "git reset hunk" })
				map("n", "<leader>hS", gs.stage_buffer, { desc = "git Stage buffer" })
				map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "undo stage hunk" })
				map("n", "<leader>hR", gs.reset_buffer, { desc = "git Reset buffer" })
				map("n", "<leader>hp", gs.preview_hunk, { desc = "preview git hunk" })
				map("n", "<leader>hb", function()
					gs.blame_line({ full = false })
				end, { desc = "git blame line" })
				map("n", "<leader>hd", gs.diffthis, { desc = "git diff against index" })
				map("n", "<leader>hD", function()
					gs.diffthis("~")
				end, { desc = "git diff against last commit" })

				-- Toggles
				map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "toggle git blame line" })
				map("n", "<leader>td", gs.toggle_deleted, { desc = "toggle git show deleted" })

				-- Text object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "select git hunk" })
			end,
		},
	},

	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = true,
	},

	{
		-- Set lualine as statusline
		"nvim-lualine/lualine.nvim",
		-- See `:help lualine.txt`
		opts = {
			options = {
				icons_enabled = false,
				theme = "gruvbox",
				component_separators = "|",
				section_separators = "",
			},
		},
	},

	{
		-- Add indentation guides even on blank lines
		"lukas-reineke/indent-blankline.nvim",
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help ibl`
		main = "ibl",
		opts = {},
	},

	-- "gc" to comment visual regions/lines
	{ "numToStr/Comment.nvim", opts = {} },

	-- Fuzzy Finder (files, lsp, etc)
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- Fuzzy Finder Algorithm which requires local dependencies to be built.
			-- Only load if `make` is available. Make sure you have the system
			-- requirements installed.
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				-- NOTE: If you are having trouble with this installation,
				--       refer to the README for telescope-fzf-native for more instructions.
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
		},
	},

	{
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
	},
}, {})

-- [[ Setting options ]]

-- Set tab_width
vim.o.tabstop = 4

-- Set theme
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

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

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-u>"] = false,
				["<C-d>"] = false,
			},
		},
	},
})

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
	-- Use the current buffer's path as the starting point for the git search
	local current_file = vim.api.nvim_buf_get_name(0)
	local current_dir
	local cwd = vim.fn.getcwd()
	-- If the buffer is not associated with a file, return nil
	if current_file == "" then
		current_dir = cwd
	else
		-- Extract the directory from the current file's path
		current_dir = vim.fn.fnamemodify(current_file, ":h")
	end

	-- Find the Git root directory from the current file's path
	local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
	if vim.v.shell_error ~= 0 then
		print("Not a git repository. Searching on current working directory")
		return cwd
	end
	return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
	local git_root = find_git_root()
	if git_root then
		require("telescope.builtin").live_grep({
			search_dirs = { git_root },
		})
	end
end

vim.api.nvim_create_user_command("LiveGrepGitRoot", live_grep_git_root, {})

-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })

local function telescope_live_grep_open_files()
	require("telescope.builtin").live_grep({
		grep_open_files = true,
		prompt_title = "Live Grep in Open Files",
	})
end
vim.keymap.set("n", "<leader>s/", telescope_live_grep_open_files, { desc = "[S]earch [/] in Open Files" })
vim.keymap.set("n", "<leader>ss", require("telescope.builtin").builtin, { desc = "[S]earch [S]elect Telescope" })
vim.keymap.set("n", "<leader>gf", require("telescope.builtin").git_files, { desc = "Search [G]it [F]iles" })
vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sG", ":LiveGrepGitRoot<cr>", { desc = "[S]earch by [G]rep on Git Root" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", require("telescope.builtin").resume, { desc = "[S]earch [R]esume" })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
	require("nvim-treesitter.configs").setup({
		modules = {},
		sync_install = false,
		ignore_install = {},

		-- Add languages to be installed here that you want installed for treesitter
		ensure_installed = {
			"c",
			"cpp",
			"go",
			"lua",
			"python",
			"rust",
			"tsx",
			"javascript",
			"typescript",
			"vimdoc",
			"vim",
			"bash",
			"dart",
		},

		-- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
		auto_install = false,

		highlight = { enable = true },
		indent = { enable = true },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<m-up>",
				node_incremental = "<m-up>",
				-- scope_incremental = "<m-up>",
				node_decremental = "<m-down>",
			},
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					["aa"] = "@parameter.outer",
					["ia"] = "@parameter.inner",
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
				},
			},
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					["]m"] = "@function.outer",
					["]]"] = "@class.outer",
				},
				goto_next_end = {
					["]M"] = "@function.outer",
					["]["] = "@class.outer",
				},
				goto_previous_start = {
					["[m"] = "@function.outer",
					["[["] = "@class.outer",
				},
				goto_previous_end = {
					["[M"] = "@function.outer",
					["[]"] = "@class.outer",
				},
			},
			swap = {
				enable = true,
				swap_next = {
					["<leader>a"] = "@parameter.inner",
				},
				swap_previous = {
					["<leader>A"] = "@parameter.inner",
				},
			},
		},
	})
end, 0)

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
	-- NOTE: Remember that lua is a real programming language, and as such it is possible
	-- to define small helper and utility functions so you don't have to repeat yourself
	-- many times.
	--
	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, { desc = "Format current buffer with LSP" })
end

local nmap = function(keys, func, desc)
	if desc then
		desc = "LSP: " .. desc
	end

	vim.keymap.set("n", keys, func, { desc = desc })
end

nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

-- See `:help K` for why this keymap
nmap("K", vim.lsp.buf.hover, "Hover Documentation")
nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

-- Lesser used LSP functionality
nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
nmap("<leader>wl", function()
	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, "[W]orkspace [L]ist Folders")

-- document existing key chains
require("which-key").register({
	["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
	["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
	["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
	["<leader>h"] = { name = "Git [H]unk", _ = "which_key_ignore" },
	["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
	["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
	["<leader>t"] = { name = "[T]oggle", _ = "which_key_ignore" },
	["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
})
-- register which-key VISUAL mode
-- required for visual <leader>hs (hunk stage) to work
require("which-key").register({
	["<leader>"] = { name = "VISUAL <leader>" },
	["<leader>h"] = { "Git [H]unk" },
}, { mode = "v" })

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require("mason").setup()
require("mason-lspconfig").setup()

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
--
--- List of server see here: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
local servers = {
	-- clangd = {},
	-- gopls = {},
	pyright = {},
	-- rust_analyzer = {},
	-- tsserver = {},
	-- html = { filetypes = { 'html', 'twig', 'hbs'} },
	bashls = {},
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
			-- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
			-- diagnostics = { disable = { 'missing-fields' } },
		},
	},
}

-- Setup neovim lua configuration
require("neodev").setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
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
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "path" },
	},
})

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
			filetypes = (servers[server_name] or {}).filetypes,
		})
	end,
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
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
local configs = require("lspconfig/configs")

if not configs.golangcilsp then
	configs.golangcilsp = {
		default_config = {
			cmd = { "golangci-lint-langserver" },
			root_dir = lspconfig.util.root_pattern(".git", "go.mod"),
			init_options = {
				command = {
					"golangci-lint",
					"run",
					"--enable-all",
					"--disable",
					"lll",
					"--out-format",
					"json",
					"--issues-exit-code=1",
				},
			},
		},
	}
end
lspconfig.golangci_lint_ls.setup({
	filetypes = { "go", "gomod" },
})

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

-- disable pair
vim.keymap.set("n", "<leader>dp", require("nvim-autopairs").disable, { desc = "Disable [P]air" })

-- find and Replace
vim.api.nvim_set_keymap("n", "<leader>fr", ":%s//g<Left><Left>", { noremap = true, silent = true })

-- save
vim.api.nvim_set_keymap("n", "<leader>w", ":w<CR>", { noremap = true, silent = true })

-- [[ DAP Keymaps ]]

-- DAP continue
vim.api.nvim_set_keymap("n", "<leader>dc", ":lua require('dap').continue()<CR>", { noremap = true, silent = true })

-- DAP toggle breakpoints
vim.api.nvim_set_keymap("n", "<leader>dt", ":lua require('dap').toggle_breakpoint()<CR>", {})

-- [[ END: DAP Keymaps ]]

-- disable copilot
vim.api.nvim_set_keymap(
	"n",
	"<leader>cd<CR>",
	":Copilot disable",
	{ noremap = true, silent = true, desc = "[C]opilot [D]isable" }
)

-- enable copilot
vim.api.nvim_set_keymap(
	"n",
	"<leader>ce<CR>",
	":Copilot enable",
	{ noremap = true, silent = true, desc = "[C]opilot [E]nable" }
)

function ExecuteCurrentFile()
	--  get the current filetype
	local filetype = vim.bo.filetype

	-- get current file path
	local file = vim.fn.expand("%:p")

	--  if the filetype is python
	if filetype == "python" then
		local venv = os.getenv("VIRTUAL_ENV")
		if venv then
			file = venv .. "/bin/python " .. file
		else
			file = "python3 " .. file
		end

		--  execute the current file
		vim.cmd("w")

		-- execute in term
		vim.cmd("terminal " .. file)
	end

	if filetype == "sh" then
		vim.cmd("w")
		vim.cmd("terminal bash " .. file)
	end
end

vim.keymap.set("n", "<leader>xf", ExecuteCurrentFile, { desc = "E[x]ecute [F]ile" })

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

local dap = require("dap")

dap.adapters.delve = {
	type = "server",
	port = "2345",
	executable = {
		command = "rogurun",
		args = { "production.env", "debug" },
	},
}

local job = require("plenary.job")

function read_dotenv()
	local dotenv = vim.fn.getcwd() .. "/production.env"
	local env = {}
	if vim.loop.fs_stat(dotenv) then
		for line in io.lines(dotenv) do
			local key, value = line:match("([^=]+)=(.*)")
			env[key] = value
		end
	end
	return env
end

dap.adapters.rogu = function(callback, _, _)
	-- NOTE: plenary.job is based on libuv, it cleans the entire environmet if you set one value
	-- so we need to copy the entire environment and set the value we need
	local _env = vim.fn.environ()
	_env["ROGU_ENV"] = "development"

	-- read the .env files
	local env = read_dotenv()
	for key, value in pairs(env) do
		_env[key] = value
	end

	job:new({
		command = "dlv",
		env = _env,
		args = { "dap", "-l", "127.0.0.1:2345" },
		on_exit = function(_, code, signal)
			print("dlv exited with code", code, signal)
		end,
		on_stdout = function(_, data)
			print("dlv stdout", data)
		end,
		on_stderr = function(_, data)
			print("dlv stderr", data)
		end,
	}):start()

	vim.defer_fn(function()
		callback({ type = "server", port = "2345", host = "127.0.0.1" })
	end, 500)
end

-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
	{
		type = "rogu",
		name = "Debug",
		request = "launch",
		program = "${file}",
	},
}

require("scrollbar").setup({
	marks = {
		Search = {
			text = { "S", "S" },
		},
		Error = {
			text = { "E", "E" },
		},
		Warn = {
			text = { "W", "W" },
		},
		Info = {
			text = { "I", "I" },
		},
		GitAdd = {
			text = "+",
		},
		GitChange = {
			text = "~",
		},
		GitDelete = {
			text = "-",
		},
	},
})
require("scrollbar.handlers.gitsigns").setup()

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
