-- Reorganize quickfix entries to prevent line number shift issues
local qf_list = vim.fn.getqflist()
if #qf_list == 0 then
	print("Quickfix list is empty")
	return
end

-- Group entries by filename while preserving original file order
local groups = {}
local file_order = {}
for _, entry in ipairs(qf_list) do
	if entry.valid == 1 then
		local filename = vim.fn.fnamemodify(entry.filename, ":p")
		if not groups[filename] then
			groups[filename] = {}
			table.insert(file_order, filename)
		end
		table.insert(groups[filename], entry)
	end
end

-- Sort entries in reverse line order within each file group
for _, filename in ipairs(file_order) do
	table.sort(groups[filename], function(a, b)
		return a.lnum > b.lnum
	end)
end

-- Create new sorted quickfix list
local new_qf = {}
for _, filename in ipairs(file_order) do
	for _, entry in ipairs(groups[filename]) do
		table.insert(new_qf, entry)
	end
end

vim.fn.setqflist({}, "r", { items = new_qf })

-- Initialize counter and define insertion function
_G.log_counter = 1

function _G.insert_qf_log()
	local bufnr = vim.api.nvim_get_current_buf()
	local row = vim.api.nvim_win_get_cursor(0)[1] - 1 -- Convert to 0-based index
	local log_line = string.format('log.Println("QF_ENTRY: %d")', _G.log_counter)

	-- Insert log line and increment counter
	vim.api.nvim_buf_set_lines(bufnr, row, row, false, { log_line })
	_G.log_counter = _G.log_counter + 1

	-- Save buffer if modifiable
	if vim.api.nvim_buf_get_option(bufnr, "modifiable") then
		vim.cmd("silent write")
	end
end

-- Execute on all quickfix entries
vim.cmd("cdo lua insert_qf_log()")
