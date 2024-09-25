local api = require('nvim-tree.api')

require('nvim-tree').setup {
    sort = {
        sorter = "case_sensitive",
    },
    view = {
        width = 30,
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
    },

}

-- 文件浏览器
vim.keymap.set({"n"}, "<M-b>", function()
    if api.tree.is_tree_buf() then
        api.tree.close()
    else
        -- api.tree.open()
        api.tree.open({find_file = true, focus = true, })
    end
end, {silent = true})
-- vim.api.nvim_set_keymap('n', "<M-b>",  "<cmd>NvimTreeToggle<cr>", { noremap = true, silent = true })
