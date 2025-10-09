--[[
@brief: file formatter plugin
@refer: https://github.com/stevearc/conform.nvim
]]

local location = 'stevearc/conform.nvim'
local config = function()
    require('conform').setup({
        formatters_by_ft = {
            c = { 'clang_format' },
            cpp = { 'clang_format' },
            json = { 'clang_format' },
            proto = { 'clang_format' },
            go = { 'gopls', 'goimports', 'gofmt' },
        },
        format_on_save = function()
            if vim.g.format_disabled == true then
                return
            end
            return { timeout_ms = 500, lsp_format = 'fallback' }
        end,
    })
end

return {
    location,
    config = config,
}