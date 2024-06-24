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
	},
})

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

-- DAP toggle repl
vim.api.nvim_set_keymap("n", "<leader>dr", ":lua require('dap').repl.toggle()<CR>", {})

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

local job = require("plenary.job")

local function read_dotenv(envfile)
	-- TODO: choose env file
	local dotenv = vim.fn.getcwd() .. "/" .. envfile
	local env = {}

	---@diagnostic disable-next-line: undefined-field
	if vim.loop.fs_stat(dotenv) then
		for line in io.lines(dotenv) do
			local key, value = line:match("([^=]+)=(.*)")
			if key ~= nil then
				env[key] = value
			end
		end
	end
	return env
end

dap.adapters.rogu = function(callback, config)
	-- NOTE: plenary.job is based on libuv, it cleans the entire environmet if you set one value
	-- so we need to copy the entire environment and set the value we need
	local _env = vim.fn.environ()

	-- read the .env files
	local env = read_dotenv(config["envfile"])
	for key, value in pairs(env) do
		_env[key] = value
	end

	local repl = require("dap.repl")

	job:new({
		command = "dlv",
		env = _env,
		args = { "dap", "-l", "127.0.0.1:" .. config["port"] },
		on_exit = function(_, code)
			if code ~= 0 then
				print("dlv exited with code", code)
			end
		end,
		on_stdout = function(error, data)
			assert(not error, error)
			if data then
				vim.schedule(function()
					repl.append(data)
				end)
			end
		end,
		on_stderr = function(_, data)
			if data then
				vim.schedule(function()
					repl.append(data)
				end)
			end
		end,
	}):start()

	vim.defer_fn(function()
		callback({ type = "server", port = config["port"], host = "127.0.0.1" })
	end, 1000)
end

dap.configurations.go = {
	{
		type = "rogu",
		name = "Rogu: production.env",
		request = "launch",
		program = "${file}",
		port = function()
			return math.random(49152, 65535)
		end,
		envfile = "production.env",
	},
}

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
