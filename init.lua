---@brief Neovim configuration file
---@refer https://github.com/ZhiWei-Ou/nvim-config
---@author Oswin

---@brief enable vim loader to improve startup time
-- if vim.loader then
--   vim.loader.enable()
-- end

---@section define global variable
---@brief Personal Neovim JSON configuration
vim.g.personal_config = vim.fn.stdpath('data') .. '/nvim-personal.json'
---@endsection

---@brief load init file
require 'init'

---@section OS Command
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
---@endsection

---@section StdPath Command
---@brief print standard path
vim.api.nvim_create_user_command('StdPath', function()
  print("config = " .. vim.fn.stdpath("config"))
  print("data = " .. vim.fn.stdpath("data"))
  print("state = " .. vim.fn.stdpath("state"))
  print("cache = " .. vim.fn.stdpath("cache"))
  print("run = " .. vim.fn.stdpath("run"))
  print("log = " .. vim.fn.stdpath("log"))
end, {})
---@endsection

---@section DebugInfo Command
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
  print("LSP = " .. table.concat(vim.tbl_map(function(c) return c.name end, vim.lsp.get_clients({ bufnr = 0 })), ", "))
  print("Filetype = " .. vim.bo.filetype)
  print("SSH = " .. (vim.env.SSH_TTY and "Yes" or "No"))
  print("TMUX = " .. (vim.env.TMUX and "Yes" or "No"))
  print("Leader = [" .. (vim.g.mapleader or "NIL") .. "]")
  print("Tabstop = " .. vim.bo.tabstop)
  print("Shiftwidth = " .. vim.bo.shiftwidth)
  print("Softtabstop = " .. vim.bo.softtabstop)
  print("Expandtab = " .. (vim.bo.expandtab and "Yes" or "No"))
  print("Background = " .. (vim.o.background == "dark" and "Dark" or "Light"))
end, {})
---@endsection
