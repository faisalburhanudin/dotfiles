local M = {}

local target_dir = "/Users/faisal/workspace/src/github.com/mcp-getgather/mcp-getgather"

function M.format_python()
  local commands = {
    "cd " .. target_dir .. " && uv run ruff format",
    "cd " .. target_dir .. " && uv run ruff check --fix"
  }
  
  for _, cmd in ipairs(commands) do
    local handle = io.popen(cmd .. " 2>&1")
    if handle then
      local result = handle:read("*a")
      local success = handle:close()
      
      if not success then
        vim.notify("Error running: " .. cmd, vim.log.levels.ERROR)
        vim.notify(result, vim.log.levels.ERROR)
        return false
      else
        vim.notify("✓ " .. cmd:match("uv run (.+)$"), vim.log.levels.INFO)
        if result and result ~= "" then
          vim.notify(result, vim.log.levels.INFO)
        end
      end
    end
  end
  
  vim.notify("Python formatting completed!", vim.log.levels.INFO)
  return true
end

function M.setup_autocmd()
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = target_dir .. "/*.py",
    callback = function(args)
      M.format_python()
      -- Let conform run after our custom formatting
      require("conform").format({ bufnr = args.buf })
    end,
    desc = "Format Python files with ruff first, then conform"
  })
end

return M
