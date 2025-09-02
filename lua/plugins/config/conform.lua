--[[
-- @brief: file formatter plugin
]]

require("conform").setup({
    formatters_by_ft = {
        c = { "clang_format" },
        cpp = { "clang_format" },
        json = { "clang_format" },
        proto = { "clang_format" },
        go = { "gopls", "goimports", "gofmt" },
    },
    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_format = "fallback",
    },
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        local root = vim.fn.getcwd()
        local ft = vim.bo.filetype

        if (ft == "c" or ft == "cpp" or ft == "cc" or ft == "h" or ft == "hpp") then
            if vim.fn.filereadable(root .. "/.clang-format") == 0 then
                return
            end
        end

        require("conform").format({ bufnr = args.buf })
    end,
})
