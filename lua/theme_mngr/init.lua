---@brief persist and restore the selected colorscheme

local config = require 'config'

local function colorscheme_exists(name)
  return type(name) == 'string' and vim.tbl_contains(vim.fn.getcompletion('', 'color'), name)
end

local theme = config.tbl 'theme' or {}
if vim.g.lite_mode and (theme.colorscheme == nil or theme.colorscheme == 'default') then
  theme.colorscheme = 'github_dark'
end

if colorscheme_exists(theme.colorscheme) then
  vim.cmd.colorscheme(theme.colorscheme)
end

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function(event)
    if not colorscheme_exists(event.match) then
      return
    end

    if require('core.project_cache').is_active() then
      return
    end

    config.update(function(config_table)
      config_table.theme = config_table.theme or {}
      config_table.theme.colorscheme = event.match
    end)
  end,
  desc = 'Persist selected colorscheme',
})
