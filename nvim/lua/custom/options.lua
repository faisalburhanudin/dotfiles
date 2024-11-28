local o = vim.o

-- Set theme
o.background = "dark"
vim.cmd([[colorscheme gruvbox]])

-- Set tab_width
o.tabstop = 4

-- Set highlight on search
o.hlsearch = false

-- Make line numbers default
o.number = true

-- Enable mouse mode
o.mouse = "a"

-- Enable break indent
o.breakindent = true

-- Save undo history
o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
o.ignorecase = true
o.smartcase = true

-- Keep signcolumn on by default
o.signcolumn = "yes"

-- Decrease update time
o.updatetime = 250
o.timeoutlen = 300

-- Set completeopt to have a better completion experience
o.completeopt = "menuone,noselect"

-- NOTE: You should make sure your terminal supports this
o.termguicolors = true

o.relativenumber = true

-- no wrap
o.wrap = false

-- no swap file
o.swapfile = false

-- make cursorline more visible
o.cursorline = true

-- avante: recommendation setup
o.laststatus = 3

-- using tree sitter as folding
o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldcolumn = "1"
o.foldlevel = 5
