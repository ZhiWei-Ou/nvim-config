-- lua/plugins/copilot.lua
---@brief [[
-- This file is for configuring GitHub Copilot plugin for Neovim.
--]]
---@date 2025-12-15
return {
  'github/copilot.vim',
  init = function()
    vim.api.nvim_create_user_command('CopilotToggle', function()
      if vim.b.copilot_enabled == false then
        vim.b.copilot_enabled = true
      else
        vim.b.copilot_enabled = false
      end
    end, {})
  end
}
