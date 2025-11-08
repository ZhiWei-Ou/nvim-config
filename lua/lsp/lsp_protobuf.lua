local G = require("lsp.general")

return {
    name = 'buf',
    opts = {
        alias = "ProtoBuf",
        on_attach = G.lsp_general_on_attach,
        filetypes = { "proto" },
    },
}
