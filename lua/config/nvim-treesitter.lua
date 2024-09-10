-- 语法高亮插件

require('nvim-treesitter.configs').setup { 
    ensure_installed = { 'c', 'cpp', 'lua', 'go', 'bash', 'cmake', 'json', 'proto', 'yaml', 'markdown_inline'}, 
    highlight = {
        enable = true,              -- 启用语法高亮
        disable = {},               -- 禁用某些语法高亮
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = 'gnn',
            node_incremental = 'grn',
            scope_incremental = 'grc',
            node_decremental = 'grm',
        },
    },
    autotag = {
        enable = true
    },
    fold = {
        enable = true
    },
}

