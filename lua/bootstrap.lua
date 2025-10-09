vim.g.bootstraptype = nil
local M = {}

function M.startup(type)
    vim.g.bootstraptype = type

    if type == 'packer' then    
        require('packer_manager').startup()
    elseif type == 'lazy' then
        require('lazy_manager')
    end
end

return M