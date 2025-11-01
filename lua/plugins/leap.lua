--[[
@breif: leap motion plugin
@refer: https://github.com/ggandor/leap.nvim
]]

local location = 'ggandor/leap.nvim'

vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap)')
vim.keymap.set('n',             'S', '<Plug>(leap-from-window)')

return {
    location,
    config = {},
}
