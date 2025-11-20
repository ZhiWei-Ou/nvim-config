--[[
@breif: mason lspconfig plugin
@refer: https://github.com/mason-org/mason-lspconfig.nvim
]]

return {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        { "neovim/nvim-lspconfig", },
    },
    config = function ()
        require("mason-lspconfig").setup({
            automatic_enable = true,
        })
    end
}
