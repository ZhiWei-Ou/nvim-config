local G = require("lsp.general")

G.lsp_config.clangd.setup{
    name = "C/C++", -- actual 'Clangd'
    cmd = {
        'clangd',
        '--background-index',
        '--clang-tidy',
        '--header-insertion=iwyu',
        '--all-scopes-completion',
        '--completion-style=detailed',
    },
    filetypes = {
        "c", "cpp", "objc", "objcpp", "cc",
        "hh", "hpp", "h", "hxx"
    },
    handlers = {
        ["textDocument/hover"] = vim.lsp.with(
            vim.lsp.handlers.hover,
            {
                border = 'double',  --  'single', 'double', 'rounded', 'solid', 'shadow'
            }
        ),
        ["textDocument/signatureHelp"] = vim.lsp.with(
            vim.lsp.handlers.signature_help,
            {
                border = 'double',  --  'single', 'double', 'rounded', 'solid', 'shadow'
                close_events = {
                    'CursorMoved',
                    'BufHidden',
                    'InsertCharPre'
                },
            }
        ),
        ['textDocument/references'] = vim.lsp.with(
            vim.lsp.handlers.references,
            {
                border = "double",
                loclist = true,
            }
        ),
    }
}
