-- git 集成插件
--[[
@brief: git integration plugin
@refer: https://github.com/lewis6991/gitsigns.nvim
]]


return {
    'lewis6991/gitsigns.nvim',
    config = _configuration,
    config = function()
        require('gitsigns').setup {
            current_line_blame = true,
        }
    end
}
