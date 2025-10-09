--[[
@brief: dashboard plugin
@refer: https://github.com/nvimdev/dashboard-nvim
]]
local requires = { { 'nvim-tree/nvim-web-devicons', opt = true } }
local event = 'VimEnter'

local function _footer() 
    if vim.g.bootstraptype == 'packer' then
        return { '', 'Current DateTime: ' .. os.date('%Y-%m-%d %H:%M:%S'), 'Startup Time: ' .. vim.g.startuptime .. ' ms' }
    end
end

local function _configuration()
    require('dashboard').setup {
        theme = 'hyper',
        shortcut_type = 'number',
        change_to_vcs_root = true,
        packages = {
            enable = true, -- show how many plugins neovim loaded
        },
        config = {
            header = vim.split(require('ui.logo'), "\n"),
            project = { enable = false, },
            mru = { enable = false, },
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

            footer = _footer(),
        },
    }
end

return {
    'nvimdev/dashboard-nvim',
    requires = requires,
    dependencies = requires,
    lazy = false,
    event = event,
    config = _configuration,
}
