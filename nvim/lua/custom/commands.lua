local function command(name, cmd)
	vim.api.nvim_create_user_command(name, cmd, {})
end

command("RelativePath", function()
	-- this will return full path
	local path = vim.fn.expand("%:p")

	local cwd = vim.fn.getcwd()

	-- substract [path] by using cwd using length of cwd
	-- lua index is start from 1 and we also need to remove "/" so #cwd + 2
	local relative_path = string.sub(path, #cwd + 2)
	vim.fn.setreg("+", relative_path)
	vim.notify("Copied path to clipboard: " .. path)
end)
