--[[
@breif: mason lspconfig plugin
@refer: https://github.com/mason-org/mason-lspconfig.nvim
]]

local location = 'mason-org/mason-lspconfig.nvim'
local after = 'mason.nvim'
local function _configuration() end

return {
    location,
    after = after,
    config = _configuration,

    dependencies = after,
}