return {
	-- =============================================
	-- CORE & ESSENTIAL
	-- =============================================
	"tpope/vim-sleuth",

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
	},

	"ellisonleao/gruvbox.nvim",

	-- =============================================
	-- EDITOR ENHANCEMENT
	-- =============================================
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPre", "BufNewFile" },
	},

	{
		"stevearc/oil.nvim",
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
	},

	-- =============================================
	-- COMPLETION & SNIPPETS
	-- =============================================
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "1.*",
	},

	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
	},

	{
		"folke/lazydev.nvim",
	},

	-- =============================================
	-- GIT INTEGRATION
	-- =============================================
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
	},

	{
		"tpope/vim-fugitive",
		cmd = { "G", "Git", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse", "GRemove", "GRename", "Glgrep", "Gedit" },
	},

	{
		"almo7aya/openingh.nvim",
		cmd = { "OpenInGHRepo", "OpenInGHFile", "OpenInGHFileLines" },
	},

	-- =============================================
	-- LSP & DEVELOPMENT
	-- =============================================
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
		},
	},

	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
	},

	-- =============================================
	-- SEARCH & NAVIGATION
	-- =============================================
	"nvim-telescope/telescope-ui-select.nvim",

	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
		},
	},

	{
		"cbochs/grapple.nvim",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons", lazy = true },
		},
		event = { "BufReadPost", "BufNewFile" },
		cmd = "Grapple",
	},

	-- =============================================
	-- SYNTAX & LANGUAGE
	-- =============================================
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
	},

	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},

	-- =============================================
	-- DEBUG & TOOLS
	-- =============================================
	{
		"andrewferrier/debugprint.nvim",
		opts = {
			keymaps = {
				normal = {
					plain_below = "<leader>dp",
					plain_above = "<leader>dP",
					variable_below = "<leader>dv",
					variable_above = "<leader>dV",
				},
			},
			commands = {
				toggle_comment_debug_prints = "ToggleCommentDebugPrints",
				delete_debug_prints = "DeleteDebugPrints",
			},
		},
	},

	-- =============================================
	-- UI COMPONENTS
	-- =============================================
	"nvim-lualine/lualine.nvim",

}
