--[[
    all of lsp configurations
]]

-- find all lsp_*.lua file in config/lua/lsp/
-- and load them
local config_path = vim.fn.stdpath("config")
local folder_path = config_path .. "/lua/lsp"
local files = vim.fn.glob(folder_path .. "/lsp_*.lua", false, true)
for _, f in ipairs(files) do
    local lsp_module = "lsp." .. f:match(".*/(.*)%.lua$")
    local ok, mod = pcall(require, lsp_module)

    -- print(lsp_module)

    if not ok then
        vim.notify("Failed to load " .. lsp_module .. ": " .. mod, vim.log.levels.ERROR)
    elseif type(mod) == 'table' then
        vim.lsp.config(mod.name, mod.opts)

        if mod.init then
            mod.init()
        end
    else
        -- nothing to happen
    end
end

