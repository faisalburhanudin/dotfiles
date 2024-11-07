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

require("lazy").setup({
	{ import = "custom.plugins", change_detection = { notify = false } },
})

require("custom.options")
require("custom.autocmds")
require("custom.snippets")
require("custom.keymaps")

-- load all plugins configs
local function plugin_configs()
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
plugin_configs()
