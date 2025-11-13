--[[
@brief: dashboard plugin
@refer: https://github.com/nvimdev/dashboard-nvim
]]

return {
    'nvimdev/dashboard-nvim',
    dependencies = { { 'nvim-tree/nvim-web-devicons', opt = true }, { 'echasnovski/mini.icons' } },
    lazy = false,
    event = 'VimEnter',

    config = function()

        -- print(vim.inspect(MiniIcons.get('directory', 'nvim')))

        require('dashboard').setup {
            theme = 'hyper',
            shortcut_type = 'letter', -- letter or number
            change_to_vcs_root = true,
            packages = {
                enable = true, -- show how many plugins neovim loaded
            },
            config = {
                header = vim.split(require('ui.logo').get_weekday(), "\n"),
                project = {
                    enable = false,
                    limit = 8,
                    icon = MiniIcons.get('directory', 'nvim'),
                    label = ' Recently Project',
                    action = 'Telescope find_files cwd='
                },
                mru = { enable = false, },
                week_header = {
                    enable = false,
                },
                shortcut = {
                    {
                        -- desc = '󰊳 Update',
                        icon = MiniIcons.get('directory', 'build'),
                        desc = ' Update',
                        group = 'Label',
                        action = vim.g.bootstrapsync,
                        key = 'u'
                    },
                    {
                        -- icon = ' ',
                        icon = MiniIcons.get('default', 'file'),
                        desc = ' Files',
                        group = 'Label',
                        action = 'Telescope find_files',
                        key = 'f',
                    },
                    {
                        -- desc = ' Colorscheme',
                        icon = MiniIcons.get('lsp', 'color'),
                        desc = ' Colorscheme',
                        group = 'Label',
                        action = 'Telescope colorscheme',
                        key = 'c',
                    },
                    {
                        -- desc = ' Commands',
                        icon = MiniIcons.get('filetype', 'help'),
                        desc = ' Commands',
                        group = 'Label',
                        action = 'Telescope',
                        key = '?',
                    }
                },
            },
        }
    end,
}
