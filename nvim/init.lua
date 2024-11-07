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
		change_detection = { notify = false },
	},
})

require("custom.options")
require("custom.autocmds")
require("custom.snippets")
require("custom.keymaps")

-- load all plugins configs
local function load_configs()
	local path = vim.fn.stdpath("config") .. "/lua/custom/configs"
	local configs = vim.fn.readdir(path)

	for _, config in ipairs(configs) do
		local value = string.match(config, "(.+).lua")
		if value == nil then
			goto continue
		end

		local config_name = "custom.configs." .. value
		require(config_name)

		::continue::
	end
end
load_configs()

local lspconfig = require("lspconfig")

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
