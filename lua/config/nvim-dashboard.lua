local logo = [[
 _____                        _                _            
|  _  |                      ( )              (_)           
| | | | _   _  ______      __|/  _ __  __   __ _  _ __ ___  
| | | || | | ||_  /\ \ /\ / /   | '_ \ \ \ / /| || '_ ` _ \ 
\ \_/ /| |_| | / /  \ V  V /    | | | | \ V / | || | | | | |
 \___/  \__,_|/___|  \_/\_/     |_| |_|  \_/  |_||_| |_| |_|
]]

logo = string.rep("\n", 3) .. logo .. "\n\n"


require('dashboard').setup {
    theme = 'hyper',
    shortcut_type = 'number',
    change_to_vcs_root = true,
    packages = {
        enable = true, -- show how many plugins neovim loaded
    },
    config = {
        header = vim.split(logo, "\n"),
        week_header = {
            enable = false,
        },
        shortcut = {
            {
                desc = '󰊳 Update',
                group = '@property',
                action = 'PackerSync',
                key = 'u'
            },
            {
                icon = ' ',
                icon_hl = '@variable',
                desc = 'Files',
                group = 'Label',
                action = 'Telescope find_files',
                key = 'f',
            },
            {
                desc = ' Colorscheme',
                group = 'DiagnosticHint',
                action = 'Telescope colorscheme',
                key = 'c',
            },
            {
                desc = ' Commands',
                group = 'DiagnosticHint',
                action = 'Telescope',
                key = 'p',
            }
        },

        footer = {'', 'Current DateTime: ' .. os.date('%Y-%m-%d %H:%M:%S')},
    },
}
