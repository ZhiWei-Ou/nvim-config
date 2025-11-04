--[[
@brief: nvim-treesitter setup
@refer: https://github.com/nvim-treesitter/nvim-treesitter/blob/main/README.md
]]
local location = 'nvim-treesitter/nvim-treesitter'
local branch = "master"
local function _run()
    local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
    ts_update()
end
local function _configuration()
end

return {
    location,
    config = _configuration,
    run = _run,

    branch = branch,
    build = ":TSUpdate",
    lazy = false,
}
