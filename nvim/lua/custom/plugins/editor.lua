return {
	-- Detect tabstop and shiftwidth automatically
	"tpope/vim-sleuth",

	-- Useful plugin to show you pending keybinds.
	"folke/which-key.nvim",

	-- theme
	"ellisonleao/gruvbox.nvim",
	"rebelot/kanagawa.nvim",

	-- "gc" to comment visual regions/lines
	"numToStr/Comment.nvim",

	-- Automatically close tags
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
	},

	-- statusline
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

	-- Add indentation guides even on blank lines
	{
		"lukas-reineke/indent-blankline.nvim",
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help ibl`
		main = "ibl",
	},

	{
		"stevearc/oil.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
	},

	-- {
	-- 	"m4xshen/autoclose.nvim",
	-- },

	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"andrewferrier/debugprint.nvim",
		dependencies = {
			"echasnovski/mini.nvim", -- Needed for :ToggleCommentDebugPrints (not needed for NeoVim 0.10+)
		},
		-- The 'keys' and 'cmds' sections of this configuration are optional and only needed if
		-- you want to take advantage of `lazy.nvim` lazy-loading. If you decide to
		-- customize the keys/commands (see below), you'll need to change these too.
		keys = {
			{ "g?", mode = "n" },
			{ "g?", mode = "x" },
		},
		cmd = {
			"ToggleCommentDebugPrints",
			"DeleteDebugPrints",
		},
	},
}
