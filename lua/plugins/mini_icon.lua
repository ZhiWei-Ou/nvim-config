--[[
@brief: icon plugin
@refer: https://github.com/nvim-mini/mini.icons
]]
return {
    "echasnovski/mini.icons",
    version = false,
    config = function()
        require("mini.icons").setup()
    end,
}