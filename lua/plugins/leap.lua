--[[
@breif: leap motion plugin
@refer: https://github.com/ggandor/leap.nvim
]]

local location = 'ggandor/leap.nvim'
local function _configuration()
    require('leap').create_default_mappings()
end

return {
    location,
    config = _configuration,
}