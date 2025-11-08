--[[
@brief: file formatter plugin
@refer: https://github.com/stevearc/conform.nvim
]]

local enable = false

return {
    'stevearc/conform.nvim',
    config = function()
        vim.api.nvim_create_user_command("FormatEnable", function()
            enable = true
        end, {})

        vim.api.nvim_create_user_command("FormatDisable", function()
            enable = false
        end, {})

        require('conform').setup({
            formatters_by_ft = {
                c = { 'clang_format' },
                cpp = { 'clang_format' },
                json = { 'clang_format' },
                proto = { 'clang_format' },
                go = { 'gopls', 'goimports', 'gofmt' },
            },
            format_on_save = function()
                if enable == false then
                    return
                end
                return { timeout_ms = 500, lsp_format = 'fallback' }
            end,
        })
    end,
}
