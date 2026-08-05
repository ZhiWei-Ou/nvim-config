-- lua/core/init.lua
---@brief load core modules in a deterministic order
---@date 2025-12-11

require 'core.options'
require 'core.clipboard'
require 'core.keymaps'
require 'core.autocmds'
require('core.binary_notice').setup()
require 'core.usercmds'
