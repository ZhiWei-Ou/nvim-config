-- lua/core/init.lua
---@brief require all core modules
---@date 2025-12-11

local uv = vim.loop
local path = debug.getinfo(1).source:sub(2) -- 当前 init.lua 路径
local dir = uv.fs_realpath(vim.fn.fnamemodify(path, ":h"))

local handle = uv.fs_scandir(dir)
if not handle then return end

while true do
  local name, t = uv.fs_scandir_next(handle)
  if not name then break end

  if name:sub(-4) == ".lua" and name ~= "init.lua" then
    local module_name = "core." .. name:sub(1, -5)
    pcall(require, module_name)
  end
end
