local G = require("lsp.general")

G.lsp_config.lua_ls.setup {
    name = "Lua",
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
            }
        }
    },
    on_attach = G.lsp_general_on_attach,
    capabilities = G.lsp_capabilities,
}
