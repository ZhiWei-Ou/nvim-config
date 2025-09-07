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

-- 文件浏览器
-- vim.keymap.set({"n"}, "<M-b>", function()
--     if api.tree.is_tree_buf() then
--         api.tree.close()
--     else
--         -- api.tree.open()
--         api.tree.open({find_file = true, focus = true, })
--     end
-- end, {silent = true})
-- vim.api.nvim_set_keymap('n', "<M-b>",  "<cmd>NvimTreeToggle<cr>", { noremap = true, silent = true })
