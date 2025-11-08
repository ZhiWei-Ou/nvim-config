local G = require("lsp.general")

return {
    name = 'lua_ls',
    opts = {
        alias = "Lua",
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                    diagnostics = {
                        'vim',
                        'describe',
                        'it',
                        'before_each',
                        'after_each',
                        'pending',
                    }
                },
                diagnostics = {
                    enable = false,
                    -- globals = { 'vim' },
                    -- disable = { 'inject-field' },
                },
                workspace = {
                    library = {
                        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                    },
                },
                telemetry = {
                    enable = false,
                },
            }
        },
        on_attach = G.lsp_general_on_attach,
        capabilities = G.lsp_capabilities,
    }
}
