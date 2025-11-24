local X = {}
local local_persistent_file = vim.fn.stdpath('config') .. '/.nvim-theme'

local function get_colorscheme_list()
  return vim.fn.getcompletion('', 'color')
end

local function reset_colorscheme()
  vim.loop.fs_unlink(local_persistent_file)
  vim.cmd.colorscheme(vim.g.default_theme)
end

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

local function loader_persistent_file()
  if vim.fn.filereadable(local_persistent_file) == 1 then
    local f = io.open(local_persistent_file, 'r')
    local theme = f:read()
    f:close()
    return theme
  end
  return vim.g.default_theme
end

function X.setup()
  vim.api.nvim_create_user_command('ListColorscheme', function()
    local colorscheme_list = get_colorscheme_list()
    print(vim.inspect(colorscheme_list))
  end, { nargs = 0 })

  vim.api.nvim_create_user_command('ResetColorscheme', function()
    reset_colorscheme()
  end, { nargs = 0 })

  local theme = loader_persistent_file()
  vim.cmd.colorscheme(theme)

  vim.api.nvim_create_autocmd(
    'ColorScheme',
    {
      pattern = '*',
      callback = function(ev)
        --[[
                event fired: {
                    buf = 32,
                    event = "ColorScheme",
                    file = "",
                    id = 95,
                    match = "default"
                }
                print(string.format('event fired: %s', vim.inspect(ev)))
                ]]

        if check_colorscheme_name_exist(ev.match) then
          local f = io.open(local_persistent_file, 'w')
          f:write(ev.match)
          f:close()
        else
          vim.notify('colorscheme not exist: ' .. ev.match, vim.log.levels.WARN)
        end
      end,
    }
  )
end

X.setup()

return X
