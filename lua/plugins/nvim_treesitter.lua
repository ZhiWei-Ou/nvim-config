--[[
@brief: nvim-treesitter setup
@refer: https://github.com/nvim-treesitter/nvim-treesitter/blob/main/README.md
]]

return {
    'nvim-treesitter/nvim-treesitter',
    branch = main,
    build = ":TSUpdate",
    lazy = false,

    config = function(_, opts)
        require('nvim-treesitter.configs').setup({
            ensure_installed = {
                "lua",
                "markdown",
                "markdown_inline",
                "vim",
            },
            auto_install = true,
            sync_install = false,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "gnn",
                    node_incremental = "grn",
                    scope_incremental = "grc",
                    node_decremental = "grm",
                },
            }
        })


        local filetype = vim.filetype

        filetype.add {
            pattern = {
                -- ssh config
                ['.*%/.*%.?ssh%.config']         = 'sshconfig',
                ['.*%/.*%.?ssh%/config']         = 'sshconfig',
                ['.*%/.*%.?ssh%/.*%.config']     = 'sshconfig',
                ['.*%/.*%.?ssh%/.*%/config']     = 'sshconfig',
                ['.*%/.*%.?ssh%/.*%/.*%.config'] = 'sshconfig',
            },
        }

    end
}
