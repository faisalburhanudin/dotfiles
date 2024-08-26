local dap = require("dap")
local job = require("plenary.job")
local dap_python = require("dap-python")
local set = vim.keymap.set

dap.adapters.delve = {
	type = "server",
	port = "${port}",
	executable = {
		command = "dlv",
		args = { "dap", "-l", "127.0.0.1:${port}" },
	},
}

dap.configurations.go = {
	{
		type = "delve",
		name = "Debug",
		request = "launch",
		program = "${file}",
	},
}

-- dap_python.setup("/Users/faisal/.virtualenvs/debugpy/bin/python")
--
-- local function save_and_run()
-- 	vim.cmd("wa")
-- 	dap.continue()
-- end
--
-- -- Keymap
-- set("n", "<leader>dd", save_and_run)
--
-- local function read_dotenv(envfile)
-- 	-- TODO: choose env file
-- 	local dotenv = vim.fn.getcwd() .. "/" .. envfile
-- 	local env = {}
--
-- 	---@diagnostic disable-next-line: undefined-field
-- 	if vim.loop.fs_stat(dotenv) then
-- 		for line in io.lines(dotenv) do
-- 			local key, value = line:match("([^=]+)=(.*)")
-- 			if key ~= nil then
-- 				env[key] = value
-- 			end
-- 		end
-- 	end
-- 	return env
-- end
--
-- dap.adapters.rogu = function(callback, config)
-- 	-- NOTE: plenary.job is based on libuv, it cleans the entire environmet if you set one value
-- 	-- so we need to copy the entire environment and set the value we need
-- 	local _env = vim.fn.environ()
--
-- 	-- read the .env files
-- 	local env = read_dotenv(config["envfile"])
-- 	for key, value in pairs(env) do
-- 		_env[key] = value
-- 	end
--
-- 	local repl = require("dap.repl")
--
-- 	job:new({
-- 		command = "dlv",
-- 		env = _env,
-- 		args = { "dap", "-l", "127.0.0.1:" .. config["port"] },
-- 		on_exit = function(_, code)
-- 			if code ~= 0 then
-- 				print("dlv exited with code", code)
-- 			end
-- 		end,
-- 		on_stdout = function(error, data)
-- 			assert(not error, error)
-- 			if data then
-- 				vim.schedule(function()
-- 					repl.append(data)
-- 				end)
-- 			end
-- 		end,
-- 		on_stderr = function(_, data)
-- 			if data then
-- 				vim.schedule(function()
-- 					repl.append(data)
-- 				end)
-- 			end
-- 		end,
-- 	}):start()
--
-- 	vim.defer_fn(function()
-- 		callback({ type = "server", port = config["port"], host = "127.0.0.1" })
-- 	end, 1000)
-- end
--
-- dap.configurations.go = {
-- 	{
-- 		type = "rogu",
-- 		name = "Rogu: production.env",
-- 		request = "launch",
-- 		program = "${file}",
-- 		port = function()
-- 			return math.random(49152, 65535)
-- 		end,
-- 		envfile = "production.env",
-- 	},
-- }
