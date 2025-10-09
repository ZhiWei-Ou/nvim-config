vim.g.bootstraptype = nil
vim.g.bootstrapsync = nil
local M = {}

function M.startup(type)
    vim.g.bootstraptype = type

    if type == 'packer' then    
        vim.g.bootstrapsync = 'PackerSync'
        require('packer_manager').startup()
    elseif type == 'lazy' then
        vim.g.bootstrapsync = 'Lazy sync'
        require('lazy_manager')
    end
end

return M
