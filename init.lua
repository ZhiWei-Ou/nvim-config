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
vim.api.nvim_create_user_command('OS', function()
  local s = vim.loop.os_uname()
  print("Neovim Version = " .. tostring(vim.version()))
  print("Machine = " .. s.machine)
  print("Release = " .. s.release)
  print("Sysname = " .. s.sysname)
  print("Version = " .. s.version)
end, {})

---@brief print standard path
vim.api.nvim_create_user_command('StdPath', function()
  print("config = " .. vim.fn.stdpath("config"))
  print("data = " .. vim.fn.stdpath("data"))
  print("state = " .. vim.fn.stdpath("state"))
  print("cache = " .. vim.fn.stdpath("cache"))
  print("run = " .. vim.fn.stdpath("run"))
  print("log = " .. vim.fn.stdpath("log"))
end, {})

---@brief print debug info
vim.api.nvim_create_user_command("DebugInfo", function()
  local info = {
    "LSP = " .. table.concat(vim.tbl_map(function(c) return c.name end, vim.lsp.get_clients({ bufnr = 0 })), ", "),
    "Filetype = " .. vim.bo.filetype,
    "SSH = " .. (vim.env.SSH_TTY and "Yes" or "No"),
    "TMUX = " .. (vim.env.TMUX and "Yes" or "No"),
    "Leader = [" .. (vim.g.mapleader or "NIL") .. "]",
  }

  print(table.concat(info, "\n"))
end, {})
