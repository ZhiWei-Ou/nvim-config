---@brief Neovim configuration file
---@refer https://github.com/ZhiWei-Ou/nvim-config
---@author Oswin

---@brief Personal Neovim JSON configuration
vim.g.personal_config = vim.fn.stdpath('data') .. '/nvim-personal.json'

---@brief load init file
require 'init'
