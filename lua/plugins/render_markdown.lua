--[[
@brief: render-markdown.nvim setup
@refer: https://github.com/MeanderingProgrammer/render-markdown.nvim
]]
local location = 'MeanderingProgrammer/render-markdown.nvim'
local after = 'nvim-treesitter'
local requires = 'echasnovski/mini.nvim' -- if you use the mini.nvim
local function _configuration()
    require('render-markdown').setup({})
end

return {
    location,
    after = after,
    requires = requires,
    config = _configuration,

    dependencies = { requires, after },
}
