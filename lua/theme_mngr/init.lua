local c = require 'config'

---@brief get colorscheme list
---@return table string[]
local function get_colorscheme_list()
  return vim.fn.getcompletion('', 'color')
end

---@brief check colorscheme name exist
---@param theme string
---@return boolean
local function check_colorscheme_name_exist(theme)
  if theme == nil then
    return false
  end

  function table.contains(list, item)
    for _, v in pairs(list) do
      if v == item then
        return true
      end
    end
    return false
  end

  return table.contains(get_colorscheme_list(), theme)
end

---@brief check current colorscheme is theme
-- local function current_colorscheme_is(theme)
--   if vim.g.colors_name == theme then
--     return true
--   else
--     return false
--   end
-- end

---@section set theme from configuration
local theme = c.tbl("theme")
if check_colorscheme_name_exist(theme.colorscheme) then
  if theme ~= nil and theme.colorscheme ~= nil then
    vim.cmd.colorscheme(theme.colorscheme)
  end
end

--[[ if theme.background == 'dark' then
  vim.o.background = 'dark'
elseif theme.background == 'light' then
  vim.o.background = 'light'
end ]]
---@endsection

---@section monitor colorscheme and background change
vim.api.nvim_create_autocmd(
  'ColorScheme',
  {
    pattern = '*',
    callback = function(ev)
      if check_colorscheme_name_exist(ev.match) --[[ and not current_colorscheme_is(ev.match) ]] then
        c.update(function(tbl)
          tbl.theme.colorscheme = ev.match
        end)
      end
    end,
  }
)
--[[ vim.api.nvim_create_autocmd(
  'OptionSet',
  {
    pattern = 'background',
    callback = function()
      c.update(function(tbl)
        tbl.theme.background = vim.o.background
      end)
    end,
  }
) ]]
---@endsection
