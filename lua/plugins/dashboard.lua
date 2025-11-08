--[[
@brief: dashboard plugin
@refer: https://github.com/nvimdev/dashboard-nvim
]]

return {
    'nvimdev/dashboard-nvim',
    dependencies = { { 'nvim-tree/nvim-web-devicons', opt = true } },
    lazy = false,
    event = 'VimEnter',
    config = function()
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
                        action = vim.g.bootstrapsync,
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
            },
        }
    end,
}
