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
}
