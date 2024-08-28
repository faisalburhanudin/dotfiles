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

		-- execute in term
		vim.cmd("terminal " .. file)
	end

	if filetype == "sh" then
		vim.cmd("terminal bash " .. file)
	end

	if filetype == "go" then
		vim.cmd("terminal go run " .. file)
	end
end

function ExecuteXRUN()
	vim.cmd("wa")

	local xrun = io.open("xrun.sh", "r")
	if xrun ~= nil then
		vim.cmd("terminal bash xrun.sh")
	end

	ExecuteCurrentFile()
end

vim.keymap.set("n", "<leader>xx", ExecuteXRUN, { desc = "E[x]ecute [x]run.sh" })
