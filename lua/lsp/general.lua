local M = {}

M.lsp_config = require('lspconfig')
M.lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

function M.lsp_general_on_attach(client, bufnr)

    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
        vim.lsp.handlers['signature_help'],
        {
            border = 'single',
            close_events = {
                'CursorMoved',
                'BufHidden',
                'InsertCharPre'
            },
        }
    )

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover,
        {
            border = 'double',  --  'single', 'double', 'rounded', 'solid', 'shadow'
        }
    )

    vim.lsp.handlers["textDocument/references"] = vim.lsp.with(
        vim.lsp.handlers.references,
        {
            border = 'double',
        }
    )

end

return M
