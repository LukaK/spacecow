-- TODO: Merge this and helper methods
-- module table
local M = {}

function M.file_exists(name)
  local f = io.open(name, "r")
  if f ~= nil then io.close(f) return true else return false end
end

--- TODO: Change to vim.notify
function M.vprequire(module_name, origin_name)
  local status_ok, module = pcall(require, module_name)
  if not status_ok then
    print("Unable to load " .. module_name .. " in " .. origin_name)
  end
  return status_ok, module
end

return M
