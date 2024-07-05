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
		vim.cmd("wa")
		vim.cmd("terminal bash " .. file)
	end
end

function ExecuteXRUN()
	vim.cmd("wa")
	vim.cmd("terminal bash xrun.sh")
end

vim.keymap.set("n", "<leader>xf", ExecuteCurrentFile, { desc = "E[x]ecute [F]ile" })
vim.keymap.set("n", "<leader>xx", ExecuteXRUN, { desc = "E[x]ecute [x]run.sh" })
