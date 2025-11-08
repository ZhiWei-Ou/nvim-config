--[[
@brief: trouble.nvim setup
@refer: https://github.com/folke/trouble.nvim
]]

return {
    'folke/trouble.nvim',
    dependencies = { { 'nvim-tree/nvim-web-devicons', opt = true } },
    keys = {
        {
            '<C-]>',
            '<cmd>Trouble symbols toggle focus=false<CR>',
            mode = { 'n' },
            desc = 'Toggle Outline'
        },
        {
            '<leader>dd',
            '<cmd>Trouble diagnostics toggle focus=false<CR>',
            mode = { 'n' },
            desc = 'Toggle Diagnostics'
        },
    },
    config = function ()
        require("trouble").setup {
            symbols = {
                desc = "Outline",
                mode = "lsp_document_symbols",
                focus = false,
                win = { position = "right" },
                filter = {
                    -- remove Package since luals uses it for control flow structures
                    ["not"] = { ft = "lua", kind = "Package" },
                    any = {
                        -- all symbol kinds for help / markdown files
                        ft = { "help", "markdown" },
                        -- default set of symbol kinds
                        kind = { "Class", "Constructor", "Enum", "Field",
                            "Function", "Interface", "Method", "Module",
                            "Namespace", "Package", "Property", "Struct",
                            "Trait", },
                    },
                },
            },
        }
    end,
}
