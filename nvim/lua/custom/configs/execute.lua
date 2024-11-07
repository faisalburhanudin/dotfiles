local function execute_file()
	--  get the current filetype
	local filetype = vim.bo.filetype

	-- get current file path
	local file = vim.fn.expand("%:p")

	--  if the filetype is python
	if filetype == "python" then
		local venv = os.getenv("VIRTUAL_ENV")
		if venv then
			return venv .. "/bin/python " .. file
		else
			return "python3 " .. file
		end
	end

	if filetype == "sh" then
		return "bash " .. file
	end

	if filetype == "go" then
		return "go run " .. file
	end

	vim.notify("No execution command found for " .. filetype)
end

local function execute()
	vim.cmd("wa")

	local cmd = ""

	local xrun = io.open("xrun.sh", "r")
	if xrun ~= nil then
		cmd = "bash xrun.sh"
	end

	local rogu_service = io.open("service.yaml", "r")
	if rogu_service ~= nil then
		cmd = "rr .env"
	end

	if cmd == "" then
		cmd = execute_file()
	end

	vim.cmd("term " .. cmd)
end

vim.keymap.set("n", "<leader>xx", execute, { desc = "E[xx]ecute" })
