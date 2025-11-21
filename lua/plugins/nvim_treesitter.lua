--- @brief: nvim-treesitter setup
--- @refer: https://github.com/nvim-treesitter/nvim-treesitter/blob/main/README.md
--- @path: ls ~/.local/share/nvim/site/**

return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,

    build = ':TSUpdate',

    opts = {
    },
    config = function ()
        require'nvim-treesitter'.setup{
            install_dir = vim.fn.stdpath('data') .. '/site'
        }

        vim.filetype.add {
            pattern = {
                -- ssh config
                ['.*%/.*%.?ssh%.config']         = 'sshconfig',
                ['.*%/.*%.?ssh%/config']         = 'sshconfig',
                ['.*%/.*%.?ssh%/.*%.config']     = 'sshconfig',
                ['.*%/.*%.?ssh%/.*%/config']     = 'sshconfig',
                ['.*%/.*%.?ssh%/.*%/.*%.config'] = 'sshconfig',
                ['rc.local']                     = 'bash',
            },
        }
    end,
}
