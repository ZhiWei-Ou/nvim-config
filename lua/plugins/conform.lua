--[[
@brief: file formatter plugin
@refer: https://github.com/stevearc/conform.nvim
]]

local enable = false

return {
    'stevearc/conform.nvim',
    init = function ()
        -- vim.api.nvim_create_autocmd("BufWritePre", {
        --     pattern = "*",
        --     callback = function(args)
        --         require("conform").format({ bufnr = args.buf })
        --     end,
        -- })
    end,
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
                json = { 'prettier' },
                proto = { 'clang_format' },
                go = { 'gofmt', 'gopls', 'goimports', top_after_first = true },
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                json = { "prettier" },
                css = { "prettier" },
                html = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
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
