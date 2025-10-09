-- git 集成插件
--[[
@brief: git integration plugin
@refer: https://github.com/lewis6991/gitsigns.nvim
]]

local location = 'lewis6991/gitsigns.nvim'
local function _configuration()
    require('gitsigns').setup {
        current_line_blame = true,
    }
end

return {
    location,
    config = _configuration,
}