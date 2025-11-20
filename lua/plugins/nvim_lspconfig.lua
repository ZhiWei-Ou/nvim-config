--[[
@brief: nvim lspconfig plugin
@refer: https://github.com/neovim/nvim-lspconfig
]]

return {
    'neovim/nvim-lspconfig',
    keys = {
        {
            'gd',
            function ()
                vim.lsp.buf.definition()
            end,
            mode = { 'n' },
            desc = 'Go to definition'
        },
        {
            'gh',
            function ()
                vim.lsp.buf.signature_help()
            end,
            mode = { 'i' },
            desc = 'Signature help'
        },
        {
            'K',
            function ()
                vim.lsp.buf.hover()
            end,
            mode = { 'n' },
            desc = 'Hover'
        },
        {
            'gr',
            function ()
                vim.lsp.buf.references()
            end,
            mode = { 'n' },
            desc = 'Show symbol references using telescope'
        },
        {
            'gt',
            function ()
                vim.lsp.buf.type_definition()
            end,
            mode = { 'n' },
            desc = 'Go to type definition'
        },
        {
            'gD',
            function ()
                vim.lsp.buf.declaration()
            end,
            mode = { 'n' },
            desc = 'Go to declaration'
        },
        {
            '<C-x><C-o>',
            function ()
                vim.lsp.buf.code_action()
            end,
            mode = { 'n' },
            desc = 'Code action'
        },
        {
            '<C-x><C-r>',
            function ()
                vim.lsp.buf.rename()
            end,
            mode = { 'n' },
            desc = 'Rename symbol'
        }
    },
    config = function()
        require("lsp")

        vim.diagnostic.config({
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = '✘',
                    [vim.diagnostic.severity.WARN]  = '▲',
                    [vim.diagnostic.severity.INFO]  = '»',
                    [vim.diagnostic.severity.HINT]  = '⚑',
                },
            },
            virtual_text = false,
            severity_sort = true,
            float = {
                border = 'rounded',
                source = 'always',
            },
        })

        vim.api.nvim_create_user_command("Diagnostic", "lua vim.diagnostic.open_float()", { nargs = 0 })

        -- 光标悬停高亮
        vim.o.updatetime = 500     -- CursorHold & CursorHoldI Expect Time (ms)
        vim.api.nvim_exec([[
        augroup LspHighlight
        autocmd!
        autocmd CursorHold  *.c,*.h,*.cpp,*.hpp,*.cc,*.hh,*.go,*.lua,*.sh lua vim.lsp.buf.document_highlight()
        autocmd CursorHoldI *.c,*.h,*.cpp,*.hpp,*.cc,*.hh,*.go,*.lua,*.sh lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved *.c,*.h,*.cpp,*.hpp,*.cc,*.hh,*.go,*.lua,*.sh lua vim.lsp.buf.clear_references()
        augroup END
        ]], false)
    end,
}
