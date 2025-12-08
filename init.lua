---@brief Neovim configuration file
---@refer https://github.com/ZhiWei-Ou/nvim-config
---@author Oswin

---@brief enable vim loader to improve startup time
-- if vim.loader then
--   vim.loader.enable()
-- end

---@brief load init file
require('init')

---@brief get os information
-- print(vim.inspect(vim.loop.os_uname()))
vim.api.nvim_create_user_command('OS', 'lua print(vim.inspect(vim.loop.os_uname()))', {})

---@brief print path
--[[ print("Config: " .. vim.fn.stdpath("config"))
print("Data: " .. vim.fn.stdpath("data"))
print("State: " .. vim.fn.stdpath("state"))
print("Cache: " .. vim.fn.stdpath("cache"))
print("Run: " .. vim.fn.stdpath("run"))
print("Log: " .. vim.fn.stdpath("log")) ]]
vim.api.nvim_create_user_command('StdPath', function()
  print("Config: " .. vim.fn.stdpath("config"))
  print("Data: " .. vim.fn.stdpath("data"))
  print("State: " .. vim.fn.stdpath("state"))
  print("Cache: " .. vim.fn.stdpath("cache"))
  print("Run: " .. vim.fn.stdpath("run"))
  print("Log: " .. vim.fn.stdpath("log"))
end, {})
