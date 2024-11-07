local telescope = require("telescope")

-- it's faster to use native fzf
telescope.load_extension("fzf")

-- ui-select native vim is hard to use, use from telescope
telescope.load_extension("ui-select")
