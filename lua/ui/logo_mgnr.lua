-- lua/ui/logo_mgnr.lua
---@brief logo manager
---@date 2025-12-17
local X = {}

local config = require 'config'
local logo_tbl = require 'ui.logo'
local default_style = 'default'

---@brief get logo from config
function X.get_logo_from_config()
  local logo_style = config.tbl().logo.style
  if not logo_style then
    config.update(function(cfg)
      cfg.logo = { style = default_style }
    end)
    logo_style = default_style
  end

  if not logo_tbl[logo_style] then
    return logo_tbl[default_style].get
  elseif logo_tbl[logo_style] then
    return logo_tbl[logo_style].get()
  end
end

vim.api.nvim_create_user_command(
  'Logo',
  function(opts)
    local args = {}
    for _, arg in ipairs(opts.fargs) do
      local k, v = arg:match("([^=]+)=(.+)")
      if k and v then
        args[k] = v
      end
    end

    local style = args["style"]

    if not table.contains(vim.tbl_keys(logo_tbl), style) then
      vim.notify('Invalid logo style: ' .. style, vim.log.levels.ERROR)
      vim.notify('Available styles: ' .. table.concat(vim.tbl_keys(logo_tbl), ', '), vim.log.levels.INFO)
      return
    else
      vim.notify('Setting logo style to: ' .. style, vim.log.levels.INFO)
    end

    config.update(function(cfg)
      cfg.logo.style = style
    end)
  end,
  {
    nargs = "+",
    complete = function(arg_lead, cmd_line, cursor_pos)
      local param_options = { "style=" }
      local style_values = { 'default', 'random' }
      for k, _ in pairs(logo_tbl) do
        table.insert(style_values, k)
      end

      local last_arg = arg_lead

      if last_arg:sub(1, 6) == "style=" then
        local partial = last_arg:sub(7)
        local matches = {}
        for _, val in ipairs(style_values) do
          if val:match("^" .. partial) then
            table.insert(matches, "style=" .. val)
          end
        end
        return matches
      else
        local matches = {}
        for _, opt in ipairs(param_options) do
          if opt:match("^" .. last_arg) then
            table.insert(matches, opt)
          end
        end
        return matches
      end
    end
  }
)

return X
