local X = {}

local env_key = 'VI_THEME'
local default_theme = 'github_dark'

local function theme_is_exist(theme)
    local themes = vim.fn.getcompletion('', 'color')

    for _, v in pairs(themes) do
        if (v == theme) then
            return true
        end
    end

    return false
end

local function set_theme(theme)
    if (theme_is_exist(theme) == false) then
        theme = default_theme
    end

    vim.cmd('colorscheme ' .. theme)
end

function X.startup(env_enable)
    env_enable = env_enable or false

    if env_enable and os.getenv(env_key) ~= nil then
        set_theme(os.getenv(env_key))
        return
    end

    set_theme(default_theme)
end

function X.print_all_themes()
    local themes = vim.fn.getcompletion('', 'color')

    for _, v in pairs(themes) do
        print(v)
    end
end

return X
