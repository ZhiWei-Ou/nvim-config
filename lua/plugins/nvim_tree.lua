--[[
@brief: nvim-tree setup
@refer: https://github.com/nvim-tree/nvim-tree.lua
]]

return {
    "nvim-tree/nvim-tree.lua",
    summary = "File Explorer",
    keys = {
        {
            '<C-l>',
            '<cmd>NvimTreeToggle<CR>',
            mode = { 'n' },
            desc = 'Toggle nvim-tree(File Explorer)'
        }
    },
    config = function()
        local api = require('nvim-tree.api')

        require('nvim-tree').setup {
            sort = {
                sorter = "case_sensitive",
            },
            view = {
                width = {
                    min = 30,
                    max = -1,
                    padding = 1,
                },
            },
            renderer = {
                symlink_destination = false,
                group_empty = true,
                icons = {
                    web_devicons = {
                        folder = {
                            enable = false,
                            color = true,
                        },
                    },
                }
            },
            filters = {
                dotfiles = true,
            },
            diagnostics = {
                enable = true,
                show_on_dirs = true,
            },
            update_focused_file = {
                enable = true,
            },
            live_filter = {
                prefix = "Search: ",
                always_show_folders = false,
            },
        }
    end,
}
