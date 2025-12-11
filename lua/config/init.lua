---@brief personal config
local X = {}
local helper = require 'helper'

local template_tbl = {
  version = tostring(vim.version()),
  theme = {
    colorscheme = "default",
    background = "dark"
  }
}

if not helper.file_exists(vim.g.personal_config) then
  local json_str = vim.json.encode(template_tbl)
  helper.file_write(vim.g.personal_config, json_str)
end

---@brief get personal config
---@return table
function X.tbl(module)
  local tbl = vim.json.decode(helper.file_readall(vim.g.personal_config))
  if module then
    return tbl[module]
  else
    return tbl
  end
end

---@brief update personal config
---@param ... function
---@return nil
function X.update(...)
  local options = { ... }
  if #options == 0 then
    return
  end

  local config_tbl = vim.json.decode(helper.file_readall(vim.g.personal_config))
  if config_tbl == nil then
    config_tbl = template_tbl
  end

  for _, f in ipairs(options) do
    if type(f) ~= 'function' then
      vim.notify('arg must be function', vim.log.levels.ERROR)
    else
      f(config_tbl)
    end
  end

  local json_str = vim.json.encode(config_tbl)
  helper.file_write(vim.g.personal_config, json_str)
end

return X
