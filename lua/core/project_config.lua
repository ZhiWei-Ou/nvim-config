---@brief Load trusted project-local configuration
---@date 2026-08-06

local M = {}

local config_dir = '.nvim'
local config_name = 'config.lua'

function M.find(start_path)
  local current = vim.fs.normalize(start_path or vim.uv.cwd())

  while current do
    local path = vim.fs.joinpath(current, config_dir, config_name)
    local stat = vim.uv.fs_stat(path)
    if stat and stat.type == 'file' then
      return path
    end

    local parent = vim.fs.dirname(current)
    if parent == current then
      break
    end
    current = parent
  end
end

function M.load(start_path)
  local path = M.find(start_path)
  if not path then
    return false
  end

  local content = vim.secure.read(path)
  if not content then
    return false
  end

  local chunk, load_error = loadstring(content, '@' .. path)
  if not chunk then
    vim.notify(load_error, vim.log.levels.ERROR, { title = 'Project config' })
    return false
  end

  local ok, runtime_error = xpcall(chunk, debug.traceback)
  if not ok then
    vim.notify(runtime_error, vim.log.levels.ERROR, { title = 'Project config' })
    return false
  end

  return true
end

return M
